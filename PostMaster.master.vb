Partial Class PostMaster
    Inherits System.Web.UI.MasterPage
    Public valuePath As Integer
    Public SumClass1 As New SumClass

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LblUserName.Text = "إسم المستخدم : " + Session("UsrName")
        If Not String.IsNullOrEmpty(Session("Work_Area")) Then
            LblUserName.Text += " - الفرع: " + Session("Work_Area").ToString()
        End If
        prmtion()
    End Sub

    'الصلاحيات
    Public Sub prmtion()
        ' Check branch access if specified
        If Session("CurrentBranch") IsNot Nothing Then
            If Not SumClass1.HasBranchAccess(Session("CurrentBranch").ToString()) Then
                Response.Redirect("~/login.aspx")
                Return
            End If
        End If

        Select Case Session("PRMTION")
            Case 1 ' Admin
                Usrs.Enabled = True
                RPT.Enabled = True
                ' Enable all features for admin
                For Each ctrl As Control In Me.Controls
                    If TypeOf ctrl Is LinkButton OrElse TypeOf ctrl Is Button Then
                        DirectCast(ctrl, WebControl).Enabled = True
                    End If
                Next
            Case 2 ' Regular user
                ' Disable admin features
                Usrs.Enabled = False
                RPT.Enabled = False
                ' Enable only branch-specific features
                For Each ctrl As Control In Me.Controls
                    If TypeOf ctrl Is LinkButton OrElse TypeOf ctrl Is Button Then
                        If ctrl.ID <> "LinkButton2" Then ' Keep logout button enabled
                            DirectCast(ctrl, WebControl).Enabled = True
                        End If
                    End If
                Next
        End Select
    End Sub

    Protected Sub LinkButton2_Click(sender As Object, e As System.EventArgs) Handles LinkButton2.Click
        ' Clear all session data
        Session.Clear()
        Session.RemoveAll()
        Session.Abandon()
        Response.Redirect("~/login.aspx")
    End Sub

End Class

