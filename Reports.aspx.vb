Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports Microsoft.Reporting.WebForms
Imports Microsoft.Reporting

Partial Class Reports
    Inherits System.Web.UI.Page
    Public SumClass1 As New SumClass
    Public err As String

    Public Sub Report1MT()
        Try

            Dim M As Date = Convert.ToDateTime(TxtDate.Text, System.Globalization.CultureInfo.GetCultureInfo("ar-Eg"))
            Dim rpDate As New ReportParameter("rpDate", M)
            Dim rpSubject_ID As New ReportParameter("rpSubject_ID", TxtSubjectID.Text)

            ' تقرير يومي
            Select Case DropReport.SelectedValue
                Case 1

                    Panel_Date.Visible = True
                    Panel_Responsible.Visible = True
                    Panel_Subject_Status.Visible = True
                    Panel_Subject.Visible = False

                    RV_1MT.Reset()
                    RV_1MT.LocalReport.ReportPath = "REPORTS\Inventory_Daily_RPT.rdlc"
                    RV_1MT.LocalReport.DataSources.Clear()
                    Dim ds As New ReportDataSource("DataSet1", Inv_DailyDataSource)
                    ds.DataSourceId = "Inv_DailyDataSource"
                    RV_1MT.LocalReport.DataSources.Add(ds)
                    RV_1MT.DataBind()
                    RV_1MT.LocalReport.SetParameters(New ReportParameter() {rpDate})

                    ' تقرير شهري
                Case 2
                    Panel_Date.Visible = True
                    Panel_Responsible.Visible = True
                    Panel_Subject_Status.Visible = True
                    Panel_Subject.Visible = False

                    RV_1MT.Reset()
                    RV_1MT.LocalReport.DataSources.Clear()
                    Dim ds As New ReportDataSource("DataSet1", InvMonthDataSource)
                    ds.DataSourceId = "InvMonthDataSource"
                    RV_1MT.LocalReport.DataSources.Add(ds)
                    RV_1MT.LocalReport.ReportPath = "REPORTS\Inventory_Month_RPT.rdlc"
                    RV_1MT.LocalReport.SetParameters(New ReportParameter() {rpDate})

                    ' تقرير بالموضوع
                Case 3
                    Panel_Date.Visible = False
                    Panel_Responsible.Visible = False
                    Panel_Subject_Status.Visible = False
                    Panel_Subject.Visible = True

                    RV_1MT.Reset()
                    RV_1MT.LocalReport.DataSources.Clear()
                    Dim ds As New ReportDataSource("DataSet1", InvMonthDataSource)
                    ds.DataSourceId = "InvDetailDataSource"
                    RV_1MT.LocalReport.DataSources.Add(ds)
                    RV_1MT.LocalReport.ReportPath = "REPORTS\Report_Detail.rdlc"
                    RV_1MT.LocalReport.SetParameters(New ReportParameter() {rpSubject_ID})

                    ' تقرير مرور رئيس القطاع
                Case 4
                    Panel_Date.Visible = True
                    Panel_Responsible.Visible = False
                    Panel_Subject_Status.Visible = False
                    Panel_Subject.Visible = False

                    RV_1MT.Reset()
                    RV_1MT.LocalReport.DataSources.Clear()
                    Dim ds As New ReportDataSource("DataSet1", Head_MonthDataSource)
                    ds.DataSourceId = "Head_MonthDataSource"
                    RV_1MT.LocalReport.DataSources.Add(ds)
                    RV_1MT.LocalReport.ReportPath = "REPORTS\Head_Sector_RPT.rdlc"
                    RV_1MT.LocalReport.SetParameters(New ReportParameter() {rpDate})

                    ' تقرير ملفات القطاع
                Case 5
                    Panel_Date.Visible = True
                    Panel_Responsible.Visible = False
                    Panel_Subject_Status.Visible = False
                    Panel_Subject.Visible = False

                    RV_1MT.Reset()
                    RV_1MT.LocalReport.DataSources.Clear()
                    Dim ds As New ReportDataSource("DataSet1", Files_MonthDataSource)
                    ds.DataSourceId = "Files_MonthDataSource"
                    RV_1MT.LocalReport.DataSources.Add(ds)
                    RV_1MT.LocalReport.ReportPath = "REPORTS\Files_Month_RPT.rdlc"
                    RV_1MT.LocalReport.SetParameters(New ReportParameter() {rpDate})

            End Select

            RV_1MT.LocalReport.Refresh()

        Catch ex As Exception
            err = "لا يوجد بيانات للعرض"
        End Try

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            'SumClass1.Session_logout()
            If Not Page.IsPostBack Then
                TxtDate.Text = Format(Now.Date, "dd/MM/yyyy")
                Txt_Work_area.Text = Session("Work_area")
                DropSubject_Year.DataBind()
                TxtSubjectID.Text = DropSubjectID.SelectedValue
                Report1MT()


                Drop_Responsible.DataBind()
                Drop_Responsible.Items.Insert(0, New ListItem("All", "%"))

            End If

        Catch ex As Exception
        End Try

        SumClass1.Session_logout()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        Report1MT()

        'If err = "لا يوجد بيانات للعرض" Then
        '    ClientScript.RegisterClientScriptBlock(Me.GetType, "ExceptionMessage", "<script type='text/JavaScript'>alert('!لا يوجد بيانات للعرض');</script>")
        'End If

    End Sub

    Protected Sub BtnMAIN_Click(sender As Object, e As System.EventArgs) Handles BtnMAIN.Click
        Response.Redirect("MAIN.aspx")
    End Sub

    Protected Sub DropReport_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropReport.SelectedIndexChanged
        Report1MT()
    End Sub

    Protected Sub DropSubjectID_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropSubjectID.SelectedIndexChanged
        TxtSubjectID.Text = DropSubjectID.SelectedValue
        Report1MT()
    End Sub

    Protected Sub Drop_Responsible_Init(sender As Object, e As EventArgs) Handles Drop_Responsible.Init
        Drop_Responsible.DataBind()
        Drop_Responsible.Items.Insert(0, New ListItem("All", "%"))
    End Sub

End Class
