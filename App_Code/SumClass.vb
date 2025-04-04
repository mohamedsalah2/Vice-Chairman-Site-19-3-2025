Imports System.Data.SqlClient

Public Class SumClass
    Inherits System.Web.UI.Page

    Private ReadOnly _connectionString As String = ConfigurationManager.ConnectionStrings("Post").ConnectionString

    ' Helper method to execute SQL commands
    Private Function ExecuteQuery(query As String, Optional parameters As SqlParameter() = Nothing) As Object
        Using conn As New SqlConnection(_connectionString)
            Using cmd As New SqlCommand(query, conn)
                If parameters IsNot Nothing Then
                    cmd.Parameters.AddRange(parameters)
                End If
                conn.Open()
                Return cmd.ExecuteScalar()
            End Using
        End Using
    End Function

    ' Helper method to execute non-query SQL commands
    Private Sub ExecuteNonQuery(query As String, parameters As SqlParameter())
        Using conn As New SqlConnection(_connectionString)
            Using cmd As New SqlCommand(query, conn)
                cmd.Parameters.AddRange(parameters)
                conn.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Using
    End Sub

    ' Insert data into Head_Sector table
    Public Sub Insert_Head_Sector(id As Integer, recordID As Integer, zone As String, ofceName As String, postalCode As String, ofceID As String, managerName As String, fellowName As String, mororDate As Date, mororTime As Integer, reportNotes As String, inform As String, actionTaken As String, followUp As String, notes As String)
        Try
            Dim query As String = "INSERT INTO Head_Sector (ID, Record_ID, Zone, OFCE_NAME, Postal_Code, OFCE_ID, Manager_Name, Fellow_Name, Moror_Date, Moror_Time, Report_Notes, inform, Action_Taken, FollowUp, Notes) VALUES (@ID, @Record_ID, @Zone, @OFCE_NAME, @Postal_Code, @OFCE_ID, @Manager_Name, @Fellow_Name, @Moror_Date, @Moror_Time, @Report_Notes, @inform, @Action_Taken, @FollowUp, @Notes)"
            Dim parameters As SqlParameter() = {
                New SqlParameter("@ID", id),
                New SqlParameter("@Record_ID", recordID),
                New SqlParameter("@Zone", zone),
                New SqlParameter("@OFCE_NAME", ofceName),
                New SqlParameter("@Postal_Code", postalCode),
                New SqlParameter("@OFCE_ID", ofceID),
                New SqlParameter("@Manager_Name", managerName),
                New SqlParameter("@Fellow_Name", fellowName),
                New SqlParameter("@Moror_Date", mororDate),
                New SqlParameter("@Moror_Time", mororTime),
                New SqlParameter("@Report_Notes", reportNotes),
                New SqlParameter("@inform", inform),
                New SqlParameter("@Action_Taken", actionTaken),
                New SqlParameter("@FollowUp", followUp),
                New SqlParameter("@Notes", notes)
            }
            ExecuteNonQuery(query, parameters)
        Catch ex As Exception
            ' Handle the exception (e.g., log the error or show a message)
            Throw New Exception("Error inserting data into Head_Sector table: " & ex.Message)
        End Try
    End Sub


    ' Get maximum Record_ID for the current year from Head_Sector table
    Public Function MaxID_Head_Sector() As Integer
        Dim query As String = "WITH CTE AS (SELECT Record_ID, Moror_Date, ROW_NUMBER() OVER (PARTITION BY YEAR(Moror_Date) ORDER BY Record_ID) AS Subject_Number FROM Head_Sector WHERE YEAR(Moror_Date) = YEAR(GETDATE())) SELECT COUNT(Subject_Number) FROM CTE"
        Dim result As Object = ExecuteQuery(query)
        If result Is DBNull.Value OrElse result Is Nothing Then
            Return 0
        Else
            Return Convert.ToInt32(result)
        End If
    End Function

    ' Insert data into Files table
    Public Sub Insert_Files(id As Integer, dDate As Date, fileID As Integer, fileSubject As String, fileContent As String, responseEmp As String, notes As String)
        Try
            Dim query As String = "INSERT INTO Files (ID, DDate, File_ID, File_Subject, File_Content, Response_emp, Notes) VALUES (@ID, @DDate, @File_ID, @File_Subject, @File_Content, @Response_emp, @Notes)"
            Dim parameters As SqlParameter() = {
                New SqlParameter("@ID", id),
                New SqlParameter("@DDate", dDate),
                New SqlParameter("@File_ID", fileID),
                New SqlParameter("@File_Subject", fileSubject),
                New SqlParameter("@File_Content", fileContent),
                New SqlParameter("@Response_emp", responseEmp),
                New SqlParameter("@Notes", notes)
            }
            ExecuteNonQuery(query, parameters)
        Catch ex As Exception
            ' Handle the exception (e.g., log the error or show a message)
            Throw New Exception("Error inserting data into Files table: " & ex.Message)
        End Try
    End Sub

    ' Get maximum ID from Inventory table
    Public Function MaxIDInv() As Integer
        Dim query As String = "SELECT MAX(ID) FROM Inventory"
        Return Convert.ToInt32(If(ExecuteQuery(query), 0))
    End Function

    ' Get maximum Subject ID for the current year
    Public Function MaxSubjectID() As Integer
        Dim query As String = "WITH CTE AS (SELECT ID, DDate, ROW_NUMBER() OVER (PARTITION BY YEAR(DDate) ORDER BY ID) AS Subject_Number FROM Inventory WHERE YEAR(DDate) = YEAR(GETDATE())) SELECT COUNT(Subject_Number) FROM CTE"
        Return Convert.ToInt32(If(ExecuteQuery(query), 0))
    End Function

    ' Get maximum ID from Files table
    Public Function MaxIDFiles() As Integer
        Dim query As String = "SELECT MAX(ID) FROM Files"
        Dim result As Object = ExecuteQuery(query)
        If result Is DBNull.Value OrElse result Is Nothing Then
            Return 0
        Else
            Return Convert.ToInt32(result)
        End If
    End Function

    ' Insert data into Inventory table
    Public Sub Insert_Inventory(id As Integer, dDate As Date, responseEmp As String, incomingType As String, postalCode As String, authority As String, empNumber As String, empName As String, subjectID As String, subject As String, subjectContent As String, inTashira As String, outTashira As String, incomingFrom As String, actionTaken As String, aditionalActions As String, requiredTime As String, aditionalTashira As String, subjectStatus As String, notes As String, workArea As String, attach1 As String, followup3 As String)
        Dim query As String = "INSERT INTO Inventory (ID, DDate, Response_emp, Incoming_Type, Postal_Code, Authority, Emp_Number, Emp_Name, Subject_ID, Subject, Subject_Content, In_Tashira, Out_Tashira, Incoming_From, Action_Taken, Aditional_Actions, Required_Time, Aditional_Tashira, Subject_Status, Notes, Work_Area, Attach1, Followup3) VALUES (@ID, @DDate, @Response_emp, @Incoming_Type, @Postal_Code, @Authority, @Emp_Number, @Emp_Name, @Subject_ID, @Subject, @Subject_Content, @In_Tashira, @Out_Tashira, @Incoming_From, @Action_Taken, @Aditional_Actions, @Required_Time, @Aditional_Tashira, @Subject_Status, @Notes, @Work_Area, @Attach1, @Followup3)"
        Dim parameters As SqlParameter() = {
            New SqlParameter("@ID", id),
            New SqlParameter("@DDate", dDate),
            New SqlParameter("@Response_emp", responseEmp),
            New SqlParameter("@Incoming_Type", incomingType),
            New SqlParameter("@Postal_Code", postalCode),
            New SqlParameter("@Authority", authority),
            New SqlParameter("@Emp_Number", empNumber),
            New SqlParameter("@Emp_Name", empName),
            New SqlParameter("@Subject_ID", subjectID),
            New SqlParameter("@Subject", subject),
            New SqlParameter("@Subject_Content", subjectContent),
            New SqlParameter("@In_Tashira", inTashira),
            New SqlParameter("@Out_Tashira", outTashira),
            New SqlParameter("@Incoming_From", incomingFrom),
            New SqlParameter("@Action_Taken", actionTaken),
            New SqlParameter("@Aditional_Actions", aditionalActions),
            New SqlParameter("@Required_Time", requiredTime),
            New SqlParameter("@Aditional_Tashira", aditionalTashira),
            New SqlParameter("@Subject_Status", subjectStatus),
            New SqlParameter("@Notes", notes),
            New SqlParameter("@Work_Area", workArea),
            New SqlParameter("@Attach1", attach1),
            New SqlParameter("@Followup3", followup3)
        }
        ExecuteNonQuery(query, parameters)
    End Sub

    ' Get client IP address (IPv4)
    Public Shared Function GetIP4Address() As String
        Dim ipAddress As String = HttpContext.Current.Request.UserHostAddress
        If ipAddress = "::1" Then
            ipAddress = "127.0.0.1"
        End If
        Return ipAddress
    End Function

    ' Enhanced session management with branch support
    Public Sub Session_logout()
        If Session("UsrName") Is Nothing Then
            ' Store the current page URL for redirect after login
            Dim currentUrl As String = HttpContext.Current.Request.Url.AbsoluteUri
            ' Remove any existing query parameters to avoid duplicate parameters
            If currentUrl.Contains("?") Then
                currentUrl = currentUrl.Substring(0, currentUrl.IndexOf("?"))
            End If
            Session("CurrentPage") = currentUrl
            
            ' Store branch information if available
            If Not String.IsNullOrEmpty(HttpContext.Current.Request.QueryString("branch")) Then
                Session("CurrentBranch") = HttpContext.Current.Request.QueryString("branch")
            End If
            
            ' Store additional context if needed
            If HttpContext.Current.Request.UrlReferrer IsNot Nothing Then
                Session("ReferrerUrl") = HttpContext.Current.Request.UrlReferrer.AbsoluteUri
            End If
            
            HttpContext.Current.Response.Redirect("~/login.aspx")
        End If
    End Sub

    ' Check if user has access to specific branch
    Public Function HasBranchAccess(branchId As String) As Boolean
        If Session("PRMTION") = 1 Then
            Return True ' Admin has access to all branches
        End If
        
        ' Check if user's work area matches the branch
        Return Session("Work_Area") IsNot Nothing AndAlso 
               Session("Work_Area").ToString().Equals(branchId, StringComparison.OrdinalIgnoreCase)
    End Function

    ' Get user's accessible branches
    Public Function GetUserBranches() As List(Of String)
        Dim branches As New List(Of String)
        
        If Session("PRMTION") = 1 Then
            ' Admin gets all branches
            Using con As New SqlConnection(ConfigurationManager.ConnectionStrings("Post_DBConnectionString").ConnectionString)
                Dim query As String = "SELECT DISTINCT Work_Area FROM USERS WHERE Work_Area IS NOT NULL AND Work_Area <> ''"
                Using cmd As New SqlCommand(query, con)
                    con.Open()
                    Using reader As SqlDataReader = cmd.ExecuteReader()
                        While reader.Read()
                            branches.Add(reader("Work_Area").ToString())
                        End While
                    End Using
                End Using
            End Using
        Else
            ' Regular users get their assigned branch
            If Session("Work_Area") IsNot Nothing Then
                branches.Add(Session("Work_Area").ToString())
            End If
        End If
        
        Return branches
    End Function

    ' Insert data into OFFICES table
    Public Sub Insert_OFFICES(id As Integer, zoneName As String, ofceName As String, ofceID As Integer, pCode As Integer, zoneID As Integer, managerName As String)
        Try
            Dim query As String = "INSERT INTO OFFICES (ID, Zone_Name, OFCE_NAME, OFCE_ID, P_Code, ZoneID, Manager_Name) VALUES (@ID, @Zone_Name, @OFCE_NAME, @OFCE_ID, @P_Code, @ZoneID, @Manager_Name)"
            Dim parameters As SqlParameter() = {
                New SqlParameter("@ID", id),
                New SqlParameter("@Zone_Name", zoneName),
                New SqlParameter("@OFCE_NAME", ofceName),
                New SqlParameter("@OFCE_ID", ofceID),
                New SqlParameter("@P_Code", pCode),
                New SqlParameter("@ZoneID", zoneID),
                New SqlParameter("@Manager_Name", managerName)
            }
            ExecuteNonQuery(query, parameters)
        Catch ex As Exception
            ' Handle the exception (e.g., log the error or show a message)
            Throw New Exception("Error inserting data into OFFICES table: " & ex.Message)
        End Try
    End Sub

    ' Get maximum ID from OFFICES table
    Public Function MaxIDOffice() As Integer
        Dim query As String = "SELECT MAX(ID) FROM OFFICES"
        Dim result As Object = ExecuteQuery(query)
        If result Is DBNull.Value OrElse result Is Nothing Then
            Return 0
        Else
            Return Convert.ToInt32(result)
        End If
    End Function
End Class