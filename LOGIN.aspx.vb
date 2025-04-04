Imports System.Data.SqlClient
Imports System.Data
Imports System.Net
Imports System.Net.NetworkInformation

Partial Class LOGIN
    Inherits System.Web.UI.Page

    Public constr As String = (ConfigurationManager.ConnectionStrings("Post").ToString)
    Public Conn As New SqlConnection(constr)

    Public SumClass1 As New SumClass

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'To get the local IPV4 address 
        Txt_IPAddress.Text = SumClass.GetIP4Address()

        'To get the local IPV6 address 
        Dim sHostName As String = Dns.GetHostName()
        Dim ipE As IPHostEntry = Dns.GetHostEntry(sHostName)
        Dim IpA As IPAddress() = ipE.AddressList
        For i As Integer = 0 To IpA.Length - 1
            'MsgBox("IP Address {0}: {1} ", i, IpA(i).ToString())
            Txt_IPAddress1.Text = IpA(i).ToString()
        Next
    End Sub

    Protected Sub LinkButton1_Click1(sender As Object, e As System.EventArgs) Handles LinkButton1.Click
        Try
            Dim SQL As String = ("SELECT * FROM USERS WHERE UsrID like N'" & TextBox1.Text & "' AND PWD='" & TextBox2.Text & "' ")
            Dim DA As New SqlDataAdapter(SQL, Conn)
            Dim DT As New DataTable
            DA.Fill(DT)

            If DT.Rows.Count = 0 Then
                LblErr.Text = "خطأ في إسم المستخدم أو كلمة المرور"
                Me.TextBox1.Text = ""
                Me.TextBox2.Text = ""
                Me.TextBox1.Focus()
                Exit Sub
            End If

            ' Set basic session information
            Session("UsrID") = DT.Rows(0).Item("UsrID").ToString
            Session("UsrName") = DT.Rows(0).Item("UsrName").ToString
            Session("PWD") = DT.Rows(0).Item("PWD").ToString
            Session("PRMTION") = DT.Rows(0).Item("PRMTION").ToString
            Session("Work_Area") = DT.Rows(0).Item("Work_Area").ToString
            Session("ID") = DT.Rows(0).Item("ID").ToString

            ' Handle branch-specific access
            If Session("CurrentBranch") IsNot Nothing Then
                Dim userBranches As List(Of String) = SumClass1.GetUserBranches()
                If Not userBranches.Contains(Session("CurrentBranch").ToString()) Then
                    LblErr.Text = "ليس لديك صلاحية الوصول إلى هذا الفرع"
                    Session.Clear()
                    Me.TextBox1.Text = ""
                    Me.TextBox2.Text = ""
                    Me.TextBox1.Focus()
                    Exit Sub
                End If
            End If

            ' Handle redirect after successful login
            If Session("CurrentPage") IsNot Nothing Then
                Dim lastPage As String = Session("CurrentPage").ToString()
                ' Clear the stored page after use
                Session("CurrentPage") = Nothing
                
                ' If there's a referrer URL, use it as fallback
                If Session("ReferrerUrl") IsNot Nothing Then
                    Session("ReferrerUrl") = Nothing
                End If
                
                Response.Redirect(lastPage)
            ElseIf Session("ReferrerUrl") IsNot Nothing Then
                ' Use referrer URL as fallback if no current page
                Dim referrerUrl As String = Session("ReferrerUrl").ToString()
                Session("ReferrerUrl") = Nothing
                Response.Redirect(referrerUrl)
            Else
                ' Default to main page if no stored page or referrer
                Response.Redirect("MAIN.aspx")
            End If
        Catch
            ClientScript.RegisterClientScriptBlock(Me.GetType, "ExceptionMessage", "<script type='text/JavaScript'>alert('   لم يتم الاتصال بقاعده البيانات !');</script>")
        End Try
    End Sub
End Class
