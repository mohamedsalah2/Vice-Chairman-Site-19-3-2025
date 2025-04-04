Imports System.Globalization
Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.Services

Partial Class Inventory
    Inherits System.Web.UI.Page
    Public SumClass1 As New SumClass
    Dim dob As DateTime

    Private Sub CLR()
        For Each ctrl As Control In Me.Form.Controls
            If TypeOf ctrl Is TextBox AndAlso ctrl.ID <> "TxtDate" Then
                DirectCast(ctrl, TextBox).Text = ""
            End If
        Next

        Txt_SubjectID.Text = (SumClass1.MaxSubjectID() + 1).ToString()

        If Not Page.IsPostBack Then
            Response.Redirect(Request.Url.AbsoluteUri)
        End If
    End Sub

    Protected Sub Btn_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Save.Click
        Try
            If String.IsNullOrEmpty(Txt_Authority.Text) Or String.IsNullOrEmpty(Txt_Subject.Text) Then
                ClientScript.RegisterClientScriptBlock(Me.GetType, "ExceptionMessage", "<script type='text/JavaScript'>alert('برجاء ادخال البيانات الاساسيه!');</script>")
                Return
            End If

            UploadFiles(FileUpload1, Txt_Attach1)
            Dim commaSeparatedFileNames As String = ConvertTextToCommaSeparated(Txt_Attach1.Text)
            Txt_Attach1.Text = commaSeparatedFileNames
            dob = Convert.ToDateTime(TxtDate.Text, CultureInfo.GetCultureInfo("ar-Eg"))

            SumClass1.Insert_Inventory(
                SumClass1.MaxIDInv() + 1, dob, Drop_Responsible.SelectedValue, Drop_IncomType.SelectedValue, Txt_PostalCode.Text, Txt_Authority.Text, Txt_EmpNo.Text,
                Txt_EmpName.Text, Txt_SubjectID.Text, Drop_Subject.SelectedValue, Txt_Subject.Text, Txt_InTashira.Text, Txt_OutTashira.Text, TXT_incoming_From.Text,
                Txt_Action_Taken.Text, Drop_Aditional_Actions.SelectedValue, Drop_Time.SelectedValue, Txt_Aditional_Tashira.Text, Drop_Subject_Status.SelectedValue,
                Txt_Notes.Text, Work_Area.SelectedValue, Txt_Attach1.Text, Followup3.Text)

            GridView1.DataBind()
            CLR()
            ClientScript.RegisterClientScriptBlock(Me.GetType(), "SuccessMessage", "<script type='text/javascript'>alert('تم الحفظ بنجاح برقم موضوع: " & SumClass1.MaxSubjectID() & "');</script>")
        Catch ex As Exception
            ' Log or handle the exception
        End Try
    End Sub

    Private Function ConvertTextToCommaSeparated(text As String) As String
        Dim fileNames As String() = text.Split(New String() {Environment.NewLine}, StringSplitOptions.RemoveEmptyEntries)
        Return String.Join(",", fileNames)
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SumClass1.Session_logout()

        If Not Page.IsPostBack Then
            dob = Convert.ToDateTime(Now, CultureInfo.GetCultureInfo("ar-Eg"))
            TxtDate.Text = Format(dob, "dd/MM/yyyy")
            Txt_SubjectID.Text = SumClass1.MaxSubjectID() + 1

            GridView1.DataSourceID = "Entry_DataSource"
            GridView1.DataBind()

            Drop_Responsible.DataBind()
            If Drop_Responsible.Items.Count > 0 AndAlso Drop_Responsible.Items.Contains(New ListItem(Session("UsrName").ToString)) Then
                Drop_Responsible.SelectedValue = Session("UsrName").ToString
                Work_Area.SelectedValue = Session("work_area").ToString
                Work_Area.DataBind()
            End If

            If Session("PRMTION") = 1 Then
                Txt_Password.Visible = True
            End If
        End If
        Txt_IPAddress.Text = SumClass.GetIP4Address()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.RowIndex = 0 Then
                e.Row.Style.Add("height", "50px")
            End If

            Dim selectedWork_Area As String = Work_Area.SelectedValue
            Dim rowWork_Area As String = DataBinder.Eval(e.Row.DataItem, "Work_Area").ToString()

            If rowWork_Area <> selectedWork_Area AndAlso Session("PRMTION") = 2 Then
                e.Row.BackColor = System.Drawing.Color.Aquamarine
                Dim btnDelete As LinkButton = TryCast(e.Row.FindControl("LinkButton4"), LinkButton)
                If btnDelete IsNot Nothing Then
                    btnDelete.Enabled = False
                    btnDelete.ForeColor = System.Drawing.Color.Gray
                    btnDelete.OnClientClick = "return false;"
                End If
            End If
        End If
    End Sub

    Protected Sub Txt_PostalCode_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Txt_PostalCode.TextChanged
        Txt_PostalCode.Text = Txt_PostalCode.Text.ToUpper()
    End Sub

    Protected Sub Btn_Search_Click(sender As Object, e As EventArgs) Handles Btn_Search.Click
        GridView1.DataSourceID = "InvSearch"
        GridView1.DataBind()
    End Sub

    Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Select Case e.CommandName
            Case "Download" : HandleDownloadCommand(e)
            Case "DeleteAttachment" : HandleDeleteAttachmentCommand(e)
            Case "Upload" : HandleUploadCommand(e)
            Case "Edit", "Delete" : pnlFilePopup.Visible = False
        End Select

        If e.CommandName = "Edit" Then
            LinkButton6_Click(sender, e)
        End If
        GridView1.DataBind()
    End Sub

    Protected Sub LinkButton6_Click(sender As Object, e As EventArgs)
        Try
            ' Get the LinkButton that was clicked
            Dim btn As LinkButton = DirectCast(sender, LinkButton)

            ' Get the row ID from the CommandArgument
            Dim rowId As String = btn.CommandArgument

            ' Store the row ID in the hidden field
            HiddenFieldEditRecordID.Value = rowId

            ' Get the data for this record
            Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("Post_DBConnectionString").ConnectionString)
                conn.Open()

                Dim cmd As New SqlCommand("SELECT * FROM Inventory WHERE ID = @ID", conn)
                cmd.Parameters.AddWithValue("@ID", rowId)

                Using reader As SqlDataReader = cmd.ExecuteReader()
                    If reader.Read() Then
                        ' Set values for dropdown lists
                        txtEditIncomingType.SelectedValue = reader("Incoming_Type").ToString()
                        txtEditAuthority.Value = reader("Authority").ToString()
                        txtEditSubject.SelectedValue = reader("Subject").ToString()
                        txtEditIncomingFrom.Value = reader("Incoming_From").ToString()
                        txtEditAditionalActions.SelectedValue = reader("Aditional_Actions").ToString()
                        txtEditSubjectStatus.SelectedValue = reader("Subject_Status").ToString()
                        txtEditRequiredTime.SelectedValue = reader("Required_Time").ToString()

                        ' Set values for other fields
                        txtEditPostalCode.Text = reader("Postal_Code").ToString()
                        txtEditEmpNumber.Text = reader("Emp_Number").ToString()
                        txtEditEmpName.Text = reader("Emp_Name").ToString()
                        txtEditSubjectContent.Text = reader("Subject_Content").ToString()
                        txtEditInTashira.Text = reader("In_Tashira").ToString()
                        txtEditOutTashira.Text = reader("Out_Tashira").ToString()
                        txtEditActionTaken.Text = reader("Action_Taken").ToString()
                        txtEditAditionalTashira.Text = reader("Aditional_Tashira").ToString()
                        txtEditNotes.Text = reader("Notes").ToString()
                        txtEditFollowup3.Text = reader("Followup3").ToString()
                    End If
                End Using
            End Using

            ' Register a script to show the popup
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowEditPopup",
                String.Format("openEditPopup('{0}');", rowId), True)

        Catch ex As Exception
            ' Log the error and show a user-friendly message
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ErrorAlert",
                "alert('حدث خطأ أثناء تحميل البيانات. يرجى المحاولة مرة أخرى.');", True)
        End Try
    End Sub

    Private Function GetRowData(rowID As Integer) As DataTable
        Try
            ' Fetch the row data from the database
            Dim query As String = "SELECT * FROM Inventory WHERE ID = @ID"
            Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("Post_DBConnectionString").ConnectionString)
                Using cmd As New SqlCommand(query, conn)
                    cmd.Parameters.AddWithValue("@ID", rowID)
                    Dim dt As New DataTable()
                    conn.Open()
                    dt.Load(cmd.ExecuteReader())
                    Return dt
                End Using
            End Using
        Catch ex As Exception
            Throw New Exception("Error fetching row data: " & ex.Message)
        End Try
    End Function

    Protected Sub btnSaveEdit_Click(sender As Object, e As EventArgs)
        Try
            ' Get the record ID from the hidden field
            Dim rowID As Integer = Convert.ToInt32(HiddenFieldEditRecordID.Value)

            ' Update the row data in the database
            Dim query As String = "UPDATE Inventory SET " & _
                "Incoming_Type = @Incoming_Type, " & _
                "Postal_Code = @Postal_Code, " & _
                "Authority = @Authority, " & _
                "Emp_Number = @Emp_Number, " & _
                "Emp_Name = @Emp_Name, " & _
                "Subject = @Subject, " & _
                "Subject_Content = @Subject_Content, " & _
                "In_Tashira = @In_Tashira, " & _
                "Out_Tashira = @Out_Tashira, " & _
                "Aditional_Tashira = @Aditional_Tashira, " & _
                "Followup3 = @Followup3, " & _
                "Incoming_From = @Incoming_From, " & _
                "Action_Taken = @Action_Taken, " & _
                "Aditional_Actions = @Aditional_Actions, " & _
                "Required_Time = @Required_Time, " & _
                "Subject_Status = @Subject_Status, " & _
                "Notes = @Notes " & _
                "WHERE ID = @ID"

            Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("Post_DBConnectionString").ConnectionString)
                Using cmd As New SqlCommand(query, conn)
                    ' Get values from dropdown lists
                    cmd.Parameters.AddWithValue("@Incoming_Type", txtEditIncomingType.SelectedValue)
                    cmd.Parameters.AddWithValue("@Authority", txtEditAuthority.Value)
                    cmd.Parameters.AddWithValue("@Subject", txtEditSubject.SelectedValue)
                    cmd.Parameters.AddWithValue("@Incoming_From", txtEditIncomingFrom.Value)
                    cmd.Parameters.AddWithValue("@Aditional_Actions", txtEditAditionalActions.SelectedValue)
                    cmd.Parameters.AddWithValue("@Required_Time", txtEditRequiredTime.SelectedValue)
                    cmd.Parameters.AddWithValue("@Subject_Status", txtEditSubjectStatus.SelectedValue)

                    ' Get values from other fields
                    cmd.Parameters.AddWithValue("@Postal_Code", txtEditPostalCode.Text)
                    cmd.Parameters.AddWithValue("@Emp_Number", txtEditEmpNumber.Text)
                    cmd.Parameters.AddWithValue("@Emp_Name", txtEditEmpName.Text)
                    cmd.Parameters.AddWithValue("@Subject_Content", txtEditSubjectContent.Text)
                    cmd.Parameters.AddWithValue("@In_Tashira", txtEditInTashira.Text)
                    cmd.Parameters.AddWithValue("@Out_Tashira", txtEditOutTashira.Text)
                    cmd.Parameters.AddWithValue("@Action_Taken", txtEditActionTaken.Text)
                    cmd.Parameters.AddWithValue("@Aditional_Tashira", txtEditAditionalTashira.Text)
                    cmd.Parameters.AddWithValue("@Notes", txtEditNotes.Text)
                    cmd.Parameters.AddWithValue("@Followup3", txtEditFollowup3.Text)
                    cmd.Parameters.AddWithValue("@ID", rowID)

                    conn.Open()
                    cmd.ExecuteNonQuery()
                End Using
            End Using

            ' Hide the popup
            pnlEditPopup.Style("display") = "none"

            ' Refresh the GridView
            GridView1.DataBind()

            ' Show success message
            ClientScript.RegisterStartupScript(Me.GetType(), "Success", "alert('تم تحديث البيانات بنجاح');", True)
        Catch ex As Exception
            ClientScript.RegisterStartupScript(Me.GetType(), "Error", "alert('Error updating data: " & ex.Message & "');", True)
        End Try
    End Sub

    Protected Sub btnCancelEdit_Click(sender As Object, e As EventArgs)
        ' Hide the edit popup
        pnlEditPopup.Visible = False

        ' Clear the hidden field
        HiddenFieldEditRecordID.Value = ""
    End Sub

    Private Sub HandleDownloadCommand(e As GridViewCommandEventArgs)
        Dim fileNames As String = e.CommandArgument.ToString().Trim()
        Dim fileList As List(Of String) = fileNames.Split(","c).ToList()

        Dim btn As ImageButton = TryCast(e.CommandSource, ImageButton)
        If btn IsNot Nothing Then
            Dim row As GridViewRow = TryCast(btn.NamingContainer, GridViewRow)
            Dim rowIndex As Integer = row.RowIndex
            Dim recordID As String = GridView1.DataKeys(rowIndex).Value.ToString()

            HiddenFieldRecordID.Value = recordID
            DisplayFileSelectionPopup(fileList)
        End If
    End Sub

    Private Sub HandleDeleteAttachmentCommand(e As GridViewCommandEventArgs)
        Dim row As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
        Dim recordID As String = GridView1.DataKeys(row.RowIndex).Value.ToString()

        Dim connStr As String = ConfigurationManager.ConnectionStrings("post_DBConnectionString").ConnectionString
        Dim fileNames As String = ""

        Using conn As New SqlConnection(connStr)
            conn.Open()
            Dim query As String = "SELECT Attach1 FROM Inventory WHERE ID = @ID"
            Using cmd As New SqlCommand(query, conn)
                cmd.Parameters.AddWithValue("@ID", recordID)
                Dim result As Object = cmd.ExecuteScalar()
                If result IsNot Nothing Then
                    fileNames = result.ToString()
                End If
            End Using
        End Using

        If Not String.IsNullOrEmpty(fileNames) Then
            Dim files As String() = fileNames.Split(","c)
            For Each file As String In files
                Dim filePath As String = Server.MapPath("~/Attachments/" & file.Trim())
                If System.IO.File.Exists(filePath) Then
                    System.IO.File.Delete(filePath)
                End If
            Next
        End If

        Using conn As New SqlConnection(connStr)
            conn.Open()
            Dim query As String = "UPDATE Inventory SET Attach1 = NULL WHERE ID = @ID"
            Using cmd As New SqlCommand(query, conn)
                cmd.Parameters.AddWithValue("@ID", recordID)
                cmd.ExecuteNonQuery()
            End Using
        End Using

        GridView1.DataBind()
    End Sub

    Private Sub HandleUploadCommand(e As GridViewCommandEventArgs)
        Dim btn As LinkButton = TryCast(e.CommandSource, LinkButton)
        If btn IsNot Nothing Then
            Dim row As GridViewRow = TryCast(btn.NamingContainer, GridViewRow)
            Dim recordID As String = GridView1.DataKeys(row.RowIndex).Value.ToString()
            HiddenFieldRecordID.Value = recordID

            Dim currentAttach1Value As String = GetAttach1FileNames(recordID)
            pnlFilePopup.Style("display") = "block"

            Dim fileUpload As FileUpload = TryCast(row.FindControl("FileUploadMulti"), FileUpload)
            Dim uploadedFiles As New List(Of String)()

            If uploadedFiles.Count > 0 Then
                Dim newAttachments As String = If(String.IsNullOrEmpty(currentAttach1Value), "", currentAttach1Value & ",") & String.Join(",", uploadedFiles)
                UpdateAttach1FileNamesInDatabase(recordID, newAttachments)

                ClientScript.RegisterStartupScript(Me.GetType(), "FilesUploaded", "alert('Files uploaded successfully.');", True)
                LoadFileListFromDatabase(recordID)
            Else
                ClientScript.RegisterStartupScript(Me.GetType(), "NoFiles", "alert('Please select a file to upload.');", True)
                pnlFilePopup.Style("display") = "block"
            End If
        End If
    End Sub

    Private Sub UpdateAttach1FileNamesInDatabase(rowId As Integer, updatedFileNames As String)
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("Post_DBConnectionString").ConnectionString
        Dim query As String = "UPDATE Inventory SET Attach1 = @Attach1 WHERE ID = @ID"

        Using conn As New SqlConnection(connectionString)
            Using cmd As New SqlCommand(query, conn)
                cmd.Parameters.AddWithValue("@Attach1", updatedFileNames)
                cmd.Parameters.AddWithValue("@ID", rowId)
                conn.Open()
                cmd.ExecuteNonQuery()
                conn.Close()
            End Using
        End Using
    End Sub

    Private Function GetAttach1FileNames(recordID As String) As String
        Dim fileNames As String = String.Empty
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("Post_DBConnectionString").ConnectionString
        Dim query As String = "SELECT Attach1 FROM Inventory WHERE ID = @ID"

        Using conn As New SqlConnection(connectionString)
            Using cmd As New SqlCommand(query, conn)
                cmd.Parameters.AddWithValue("@ID", recordID)
                conn.Open()
                Dim result = cmd.ExecuteScalar()
                If result IsNot Nothing Then
                    fileNames = result.ToString()
                End If
                conn.Close()
            End Using
        End Using

        Return fileNames
    End Function

    Protected Sub DisplayFileSelectionPopup(fileList As List(Of String))
        cblFileListPopup.DataSource = fileList
        cblFileListPopup.DataBind()
        pnlFilePopup.Style("display") = "block"
    End Sub

    Protected Sub btnClosePopup_Click(sender As Object, e As EventArgs)
        Dim script As String = "document.getElementById('" & pnlFilePopup.ClientID & "').style.display = 'none';"
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ClosePopup", script, True)
        cblFileListPopup.Items.Clear()
    End Sub

    Protected Sub btnUploadFiles_Click(sender As Object, e As EventArgs)
        If String.IsNullOrEmpty(HiddenFieldRecordID.Value) Then
            ClientScript.RegisterStartupScript(Me.GetType(), "NoRecordSelected", "alert('Please select a record to upload files.');", True)
            Return
        End If

        Dim uploadFolder As String = Server.MapPath("~/Attachments/")
        If Not Directory.Exists(uploadFolder) Then
            Directory.CreateDirectory(uploadFolder)
        End If

        If FileUploadMulti.HasFiles Then
            Dim uploadedFiles As New List(Of String)()
            For Each file As HttpPostedFile In FileUploadMulti.PostedFiles
                If file.ContentLength > 0 Then
                    Dim originalFileName As String = Path.GetFileNameWithoutExtension(file.FileName)
                    Dim fileExtension As String = Path.GetExtension(file.FileName)
                    Dim uniqueFileName As String = originalFileName & fileExtension
                    Dim savePath As String = Path.Combine(uploadFolder, uniqueFileName)
                    Dim counter As Integer = 1
                    While System.IO.File.Exists(savePath)
                        uniqueFileName = originalFileName & "_" & DateTime.Now.ToString("dd-MM-yyyy_HHmm") & "_" & counter.ToString() & fileExtension
                        savePath = Path.Combine(uploadFolder, uniqueFileName)
                        counter += 1
                    End While
                    file.SaveAs(savePath)
                    uploadedFiles.Add(uniqueFileName)
                End If
            Next

            If uploadedFiles.Count > 0 Then
                Dim currentAttach1Value As String = GetAttach1FileNames(HiddenFieldRecordID.Value)
                Dim newAttachments As String = String.Join(",", uploadedFiles)
                If Not String.IsNullOrEmpty(currentAttach1Value) Then
                    newAttachments = currentAttach1Value & "," & newAttachments
                End If
                UpdateAttach1FileNamesInDatabase(HiddenFieldRecordID.Value, newAttachments)
                ClientScript.RegisterStartupScript(Me.GetType(), "FilesUploaded", "alert('Files uploaded successfully.');", True)
                LoadFileListFromDatabase(HiddenFieldRecordID.Value)
            End If
        Else
            ClientScript.RegisterStartupScript(Me.GetType(), "NoFilesUploaded", "alert('No files were selected for upload.');", True)
        End If
        GridView1.DataBind()
    End Sub

    Protected Sub btnDownloadSelectedPopup_Click(sender As Object, e As EventArgs)
        Dim selectedFiles As New List(Of String)()
        Dim missingFiles As New List(Of String)()

        For Each item As ListItem In cblFileListPopup.Items
            If item.Selected Then
                Dim filePath As String = "~/Attachments/" & item.Value
                Dim serverFilePath As String = Server.MapPath(filePath)
                If File.Exists(serverFilePath) Then
                    selectedFiles.Add(filePath)
                Else
                    missingFiles.Add(item.Value)
                End If
            End If
        Next

        If missingFiles.Count > 0 Then
            Dim missingFilesMessage As String = "The following files do not exist: " & String.Join(", ", missingFiles)
            Dim script As String = "alert('" & missingFilesMessage.Replace("'", "\'") & "');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "MissingFilesAlert", script, True)
            Dim showPopupScript As String = "document.getElementById('" & pnlFilePopup.ClientID & "').style.display = 'block';"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", showPopupScript, True)
            Return
        End If

        If selectedFiles.Count > 0 Then
            Dim downloadOption As String = rblDownloadOption.SelectedValue
            If downloadOption = "Individual" Then
                Dim fileUrls As String = String.Join(",", selectedFiles.Select(Function(file) ResolveUrl(file)))
                Dim script As String = "setTimeout(function() { downloadFiles('" & fileUrls & "'); }, 0);"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "downloadFiles", script, True)
            ElseIf downloadOption = "Zip" Then
                Dim tempFolderPath As String = Server.MapPath("~/Temp")
                Dim tempZipPath As String = Path.Combine(tempFolderPath, "SelectedFiles.zip")
                If Not Directory.Exists(tempFolderPath) Then
                    Directory.CreateDirectory(tempFolderPath)
                End If
                If File.Exists(tempZipPath) Then
                    File.Delete(tempZipPath)
                End If
                Using zip As New Ionic.Zip.ZipFile(System.Text.Encoding.UTF8)
                    For Each fileName In selectedFiles
                        Dim filePath As String = Server.MapPath(fileName)
                        If File.Exists(filePath) Then
                            zip.AddFile(filePath, "").FileName = Path.GetFileName(fileName)
                        End If
                    Next
                    zip.Save(tempZipPath)
                End Using
                Response.Clear()
                Response.ContentType = "application/zip"
                Response.AddHeader("Content-Disposition", "attachment; filename=""" & HttpUtility.UrlPathEncode("SelectedFiles.zip") & """")
                Response.TransmitFile(tempZipPath)
                Response.End()
            End If
        Else
            Dim script As String = "alert('Please select at least one file to download.');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "NoFilesSelectedAlert", script, True)
            Dim showPopupScript As String = "document.getElementById('" & pnlFilePopup.ClientID & "').style.display = 'block';"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowPopup", showPopupScript, True)
        End If
    End Sub

    Protected Sub btnDeleteSelectedPopup_Click(sender As Object, e As EventArgs)
        If String.IsNullOrEmpty(HiddenFieldRecordID.Value) Then
            Dim script As String = "alert('Please select a record to delete files.');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "NoRecordSelected", script, True)
            Return
        End If

        Dim selectedFiles As New List(Of String)()
        For Each item As ListItem In cblFileListPopup.Items
            If item.Selected Then
                selectedFiles.Add(item.Value)
            End If
        Next

        If selectedFiles.Count = 0 Then
            Dim script As String = "alert('Please select at least one file to delete.');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "NoFilesSelected", script, True)
            Return
        End If

        Dim _connectionString As String = ConfigurationManager.ConnectionStrings("Post_DBConnectionString").ToString()
        Dim currentAttach1Value As String = String.Empty
        Dim deletedFiles As New List(Of String)()

        Try
            Using connection As New SqlConnection(_connectionString)
                connection.Open()
                Dim cmdGet As New SqlCommand("SELECT Attach1 FROM Inventory WHERE ID = @ID", connection)
                cmdGet.Parameters.AddWithValue("@ID", HiddenFieldRecordID.Value)
                Dim result = cmdGet.ExecuteScalar()
                If result IsNot DBNull.Value Then
                    currentAttach1Value = Convert.ToString(result)
                End If
            End Using
        Catch ex As Exception
            Dim script As String = "alert('An error occurred while retrieving file data.');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "DatabaseError", script, True)
            Return
        End Try

        If String.IsNullOrEmpty(currentAttach1Value) Then
            Dim script As String = "alert('No files are currently attached to delete.');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "NoFilesAttached", script, True)
            Return
        End If

        Dim currentFiles As New List(Of String)(currentAttach1Value.Split(","c))
        For Each file As String In selectedFiles
            If currentFiles.Contains(file.Trim()) Then
                currentFiles.Remove(file.Trim())
                Dim filePath As String = Server.MapPath("~/Attachments/") & file.Trim()
                If System.IO.File.Exists(filePath) Then
                    Try
                        System.IO.File.Delete(filePath)
                        deletedFiles.Add(file.Trim())
                    Catch ex As Exception
                        Dim script As String = "alert('Error deleting file: " & file.Trim() & "');"
                        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "FileDeletionError", script, True)
                    End Try
                End If
            End If
        Next

        Dim updatedAttach1Value As String = String.Join(",", currentFiles)
        Try
            Using connection As New SqlConnection(_connectionString)
                connection.Open()
                Dim cmdUpdate As New SqlCommand("UPDATE Inventory SET Attach1 = @Attach1 WHERE ID = @ID", connection)
                cmdUpdate.Parameters.AddWithValue("@Attach1", updatedAttach1Value)
                cmdUpdate.Parameters.AddWithValue("@ID", HiddenFieldRecordID.Value)
                cmdUpdate.ExecuteNonQuery()
            End Using
            Dim scriptSuccess As String = "alert('Selected files have been deleted from the record.');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "FilesDeleted", scriptSuccess, True)
            LoadFileListFromDatabase(HiddenFieldRecordID.Value)
            GridView1.DataBind()
        Catch ex As Exception
            Dim script As String = "alert('An error occurred while updating the file data.');"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "UpdateError", script, True)
        End Try
    End Sub

    Private Sub LoadFileListFromDatabase(recordID As String)
        Dim connectionString As String = ConfigurationManager.ConnectionStrings("Post_DBConnectionString").ConnectionString
        Using connection As New SqlConnection(connectionString)
            connection.Open()
            Dim cmd As New SqlCommand("SELECT Attach1 FROM Inventory WHERE ID = @ID", connection)
            cmd.Parameters.AddWithValue("@ID", recordID)
            Dim attach1Value As String = Convert.ToString(cmd.ExecuteScalar())
            cblFileListPopup.Items.Clear()
            If Not String.IsNullOrEmpty(attach1Value) Then
                Dim files As String() = attach1Value.Split(","c)
                For Each file As String In files
                    cblFileListPopup.Items.Add(New ListItem(file.Trim(), file.Trim()))
                Next
            End If
        End Using
    End Sub

    Private Sub LoadFileList()
        Dim attachmentsFolder As String = Server.MapPath("~/Attachments/")
        Dim files As String() = Directory.GetFiles(attachmentsFolder)
        cblFileListPopup.Items.Clear()
        For Each file As String In files
            Dim fileName As String = Path.GetFileName(file)
            cblFileListPopup.Items.Add(New ListItem(fileName, fileName))
        Next
    End Sub

    Protected Sub ImageButton_Upload_Click(sender As Object, e As EventArgs)
        Dim btn As ImageButton = CType(sender, ImageButton)
        Dim row As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        Dim fileUpload As FileUpload = CType(row.FindControl("FileUpload1"), FileUpload)

        If fileUpload.HasFiles Then
            For Each file As HttpPostedFile In fileUpload.PostedFiles
                If file.ContentLength > 0 Then
                    Dim fileName As String = Path.GetFileName(file.FileName)
                    Dim filePath As String = "~/Attachments/" & fileName
                    file.SaveAs(Server.MapPath(filePath))
                    Dim hiddenField As HiddenField = CType(row.FindControl("HiddenField1"), HiddenField)
                    hiddenField.Value = filePath
                    Dim label As Label = CType(row.FindControl("Label_Attach1"), Label)
                    label.Text = fileName
                    label.Visible = True
                End If
            Next
        End If
    End Sub

    Private Sub UploadFiles(fileUploadControl As FileUpload, textBox As TextBox)
        Dim uploadFolder As String = Server.MapPath("~/Attachments/")
        If Not Directory.Exists(uploadFolder) Then
            Directory.CreateDirectory(uploadFolder)
        End If

        Txt_Attach1.Text = ""

        If fileUploadControl.HasFile Then
            Txt_Attach1.Text = ""
            For i As Integer = 0 To Request.Files.Count - 1
                Dim file As HttpPostedFile = Request.Files(i)
                If file.ContentLength > 0 Then
                    Dim originalFileName As String = Path.GetFileNameWithoutExtension(file.FileName)
                    Dim fileExtension As String = Path.GetExtension(file.FileName)
                    Dim fileName As String = originalFileName & fileExtension
                    Dim savePath As String = Path.Combine(uploadFolder, fileName)
                    While System.IO.File.Exists(savePath)
                        Dim timestamp As String = DateTime.Now.ToString("dd-MM-yyyy_hh-mmtt")
                        fileName = String.Format("{0}_{1}{2}", originalFileName, timestamp, fileExtension)
                        savePath = Path.Combine(uploadFolder, fileName)
                    End While
                    file.SaveAs(savePath)
                    Dim scriptSuccess As String = "alert('Selected files have been Uploaded To Server.');"
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "المرفقات", scriptSuccess, True)
                    If Not Txt_Attach1.Text.Contains(fileName & Environment.NewLine) Then
                        Txt_Attach1.Text &= fileName & Environment.NewLine
                    End If
                End If
            Next
        End If
    End Sub

    <WebMethod()>
    Public Shared Function CheckPasswordAndPermission(userPassword As String) As Boolean
        Dim isValid As Boolean = False
        Dim sessionPassword As String = TryCast(HttpContext.Current.Session("PWD"), String)
        Dim userPermission As Integer = If(HttpContext.Current.Session("PRMTION"), 0)
        Dim userID As String = TryCast(HttpContext.Current.Session("UsrID"), String)

        If String.IsNullOrEmpty(userID) Or userPermission <> 1 Then
            Return False
        End If

        If Not String.IsNullOrEmpty(sessionPassword) AndAlso sessionPassword.Trim() = userPassword.Trim() Then
            Return True
        End If

        Try
            Using con As New SqlConnection(ConfigurationManager.ConnectionStrings("Post_DBConnectionString").ConnectionString)
                Dim query As String = "SELECT PWD FROM Users WHERE UsrID = @UserID"
                Using cmd As New SqlCommand(query, con)
                    cmd.Parameters.AddWithValue("@UserID", userID)
                    con.Open()
                    Dim dbPassword As Object = cmd.ExecuteScalar()
                    con.Close()
                    If dbPassword IsNot Nothing AndAlso String.Equals(dbPassword.ToString().Trim(), userPassword.Trim(), StringComparison.OrdinalIgnoreCase) Then
                        isValid = True
                    End If
                End Using
            End Using
        Catch ex As Exception
            HttpContext.Current.Trace.Warn("Database Error: " & ex.Message)
        End Try
        Return isValid
    End Function

    Protected Sub TxtDate_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            If Not String.IsNullOrEmpty(TxtDate.Text) Then
                ' Parse the date and time from the textbox
                Dim dateTime As DateTime = DateTime.ParseExact(TxtDate.Text, "yyyy/MM/dd HH:mm", CultureInfo.InvariantCulture)
                
                ' Update the textbox with the formatted date and time
                TxtDate.Text = dateTime.ToString("yyyy/MM/dd HH:mm")
                
                ' Use the full date and time in your database operations
                ' For example:
                ' cmd.Parameters.AddWithValue("@Date", dateTime)
            End If
        Catch ex As Exception
            ' Handle any parsing errors
            Response.Write("<script>alert('خطأ في تنسيق التاريخ والوقت. الرجاء إدخال التاريخ والوقت بشكل صحيح.');</script>")
        End Try
    End Sub

    Protected Sub Timer1_Tick(sender As Object, e As EventArgs)
        LastUpdated.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss")
    End Sub
End Class