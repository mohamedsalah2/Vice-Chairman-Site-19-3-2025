<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Reports.aspx.vb" Inherits="Reports" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>التقارير</title>
    <link href="Cal/Styles/calendar-blue.css" rel="stylesheet" type="text/css" />
    <style type="text/css" dir="rtl">
        .style7
        {
            width: 100%;
            border: 2px solid #ffffff;
            background-color: #009933;
            color: #FFFFFF;
            font-weight: 700;
            font-size: large;
            font-family: "Times New Roman" , Times, serif;
        }
        .style8
        {
            font-weight: bold;
            font-size: large;
            font-family: "Times New Roman" , Times, serif;
        }
        .style9
        {
            font-weight: bold;
            font-size: large;
            font-family: "Times New Roman" , Times, serif;
            color: #003300;
            background-color: #FFFFFF;
            height: 30px;
        }
        .style10
        {
            height: 35px;
        }
        .style26
        {
            height: 35px;
            width: 202px;
        }
        .style28
        {
            height: 35px;
            width: 175px;
        }
        #form1
        {
            height: 610px;
            margin-bottom: 0px;
        }
        .style29
        {
            width: 55px;
        }
        .style6
        {}
        .auto-style1 {
            width: 100%;
            overflow: auto;
            height: 536px;
            margin-top: 3px;
        }
        .auto-style2 {
            margin-top: 20px;
        }
        .auto-style6 {
            width: 100%;
            border: 2px solid #ffffff;
            background-color: #009933;
            color: #FFFFFF;
            font-weight: 700;
            font-size: large;
            font-family: "Times New Roman" , Times, serif;
            height: 2px;
        }
        .auto-style7 {
            width: 100%;
            overflow: auto;
            height: 1080px;
        }
        .auto-style9 {
            font-weight: bold;
            font-size: large;
            font-family: "Times New Roman" , Times, serif;
            color: #003300;
            background-color: #FFFFFF;
        }
        .auto-style16 {
            font-weight: bold;
            font-size: large;
            font-family: "Times New Roman" , Times, serif;
            margin-right: 0px;
        }
        .auto-style19 {
            height: 71px;
            text-align: center;
        }
        .auto-style24 {
            font-size: medium;
        }
        .auto-style25 {
            font-size: medium;
            font-family: "Times New Roman" , Times, serif;
            color: #003300;
            background-color: #FFFFFF;
        }
        .auto-style34 {
            height: 71px;
            width: 78px;
            }
        .auto-style36 {
            margin-bottom: 0px;
        }
        .auto-style37 {
            height: 71px;
            width: 8px;
            text-align: center;
        }
        .auto-style38 {
            height: 71px;
            width: 100px;
            text-align: center;
        }
        .auto-style41 {
            height: 71px;
            text-align: center;
            width: 131px;
        }
        .auto-style43 {
            height: 71px;
        }
        .auto-style45 {
            font-size: medium;
            margin-top: 0px;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="Button1" dir="rtl" 
    style="width: 100%; height: 100%">
    <table class="auto-style6" dir="rtl">
        <tr>
            <td class="auto-style37">
                <asp:Label ID="Label3" runat="server" Text="التقرير"></asp:Label>
                <asp:DropDownList ID="DropReport" runat="server" CssClass="auto-style9" Style="text-align: center"
                    Height="30px" Width="143px" AutoPostBack="True">
                    <asp:ListItem Value="2" Selected="True">تقرير شهري</asp:ListItem>
                    <asp:ListItem Value="1">تقرير يومي</asp:ListItem>
                    <asp:ListItem Value="3">تقرير بالموضوع</asp:ListItem>
                    <asp:ListItem Value="4">تقرير مرور رئيس القطاع</asp:ListItem>
                    <asp:ListItem Value="5">ملفات القطاع شهري</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="auto-style38">
                <asp:Panel ID="Panel_Date" runat="server" Direction="RightToLeft" Width="131px">
                    <asp:Label ID="Label2" runat="server" Text="التاريخ"></asp:Label>
                    <br />
                    <asp:TextBox ID="TxtDate" runat="server" CssClass="auto-style36" Width="90px" Height="20px"></asp:TextBox>
                    <img src="cal/calender.png" alt="Click to popup the bank window!" style="width: 20px;
                    height: 26px; margin-top: 0px" id="Image_Cal" />
                </asp:Panel>
            </td>
            <td class="auto-style19">
                <asp:Panel ID="Panel_Subject" runat="server" Direction="RightToLeft" Height="55px" Width="327px">
                    <asp:Label ID="Lbl_SubjectID1" runat="server" Text="رقم الموضوع" CssClass="auto-style24"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="Lbl_Subject_Year" runat="server" CssClass="auto-style24" Height="20px" Text="السنه" Width="71px"></asp:Label>
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="TxtSubjectID" runat="server" CssClass="auto-style24" Height="20px" Width="36px">1</asp:TextBox>
                    &nbsp;
                    <asp:DropDownList ID="DropSubjectID" runat="server" AutoPostBack="True" CssClass="auto-style24" DataSourceID="SubjectlDataSource_id" DataTextField="Subject_ID" DataValueField="Subject_ID" Height="24px" Width="61px">
                    </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:DropDownList ID="DropSubject_Year" runat="server" AutoPostBack="True" CssClass="auto-style45" DataSourceID="SubjectlDataSource" DataTextField="Date" DataValueField="Date" Height="25px" Width="60px">
                    </asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </asp:Panel>
            </td>
            <td class="auto-style19">
                    <asp:TextBox ID="Txt_Work_area" runat="server" CssClass="auto-style36" Width="90px" Height="20px"></asp:TextBox>
            </td>
            <td class="auto-style41">
                <asp:Panel ID="Panel_Responsible" runat="server" Direction="RightToLeft" Width="121px">
                    <asp:Label ID="Lbl_Responsible" runat="server" Text="اسم الموظف"></asp:Label>
                    <asp:DropDownList ID="Drop_Responsible" runat="server" DataSourceID="ResponsibleSqlDataSource" DataTextField="UsrName" DataValueField="UsrName" CssClass="auto-style25" Width="118px">
                    </asp:DropDownList>
                </asp:Panel>
            </td>
            <td class="auto-style41">
                <asp:Panel ID="Panel_Subject_Status" runat="server" Direction="RightToLeft" Width="129px">
                    <asp:Label ID="Lbl_Subject_Status" runat="server" Text="موقف الموضوع"></asp:Label>
                    <asp:DropDownList ID="Drop_Subject_Status" runat="server" CssClass="auto-style25" Width="131px">
                        <asp:ListItem Value="%" Selected="True">All</asp:ListItem>
                        <asp:ListItem Value="الموضوع مفتوح">الموضوع مفتوح</asp:ListItem>
                        <asp:ListItem Value="الموضوع مغلق">الموضوع مغلق</asp:ListItem>
                    </asp:DropDownList>
                </asp:Panel>
            </td>
            <td class="auto-style34">
                <asp:Button ID="Button1" runat="server" Text="عرض التقرير" Height="40px" Width="86px"
                    CssClass="auto-style16" Font-Size="12pt" />
            </td>
            <td class="auto-style43">
                <asp:Button ID="BtnMAIN" runat="server" Text="الصفحة الرئيسية" Height="40px" Width="99px"
                    CssClass="style8" Font-Bold="True" Font-Size="11pt" />
            </td>
        </tr>
    </table>
    <script src="Cal/Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="Cal/Scripts/jquery.dynDateTime.min.js" type="text/javascript"></script>
    <script src="Cal/Scripts/calendar-en.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=TxtDate.ClientID %>").dynDateTime({
                Date: 'now',
                //                        showsTime: true,
                //                        timeFormat: "12",
                ifFormat: "%d/%m/%Y",     //date format that will be stored in the input field
                daFormat: "%m/ %e/ %Y",    //the date format that will be used to display the date in displayArea
                align: "BR",
                //align: "TL",
                electric: false,
                singleClick: true,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()",
                allowInputToggle: true

            });
        });

    </script>
    <div dir="rtl" class="auto-style1">
        <table dir="rtl" class="auto-style7">
            <tr>
                <td align="right" dir="rtl" colspan="1" rowspan="1">
                    <rsweb:ReportViewer ID="RV_1MT" runat="server" Font-Names="Verdana" Font-Size="8pt"
                        WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Height="930px" Width="100%"
                        Style="margin-bottom: 26px" SizeToReportContent="True" ZoomMode="PageWidth" RightToLeft="YES" CssClass="auto-style2">
                        <LocalReport ReportPath="REPORTS\Inventory_Daily_RPT.rdlc">
                        </LocalReport>
                    </rsweb:ReportViewer>
                </td>
            </tr>
        </table>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:SqlDataSource ID="Inv_DailyDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>"
        SelectCommand="SELECT ID, CONVERT (VARCHAR(12), DDate, 103) AS DDate, Response_emp, Incoming_Type, Postal_Code, Authority, Emp_Number, Emp_Name, Subject, Subject_Content, In_Tashira, Out_Tashira, Incoming_From, Action_Taken, Aditional_Actions, Aditional_Tashira, Subject_Status, Notes, Required_Time, Subject_ID FROM Inventory WHERE (CONVERT (VARCHAR(12), DDate, 103) = @rpDate) AND (Response_emp LIKE @Response_emp) AND (Subject_Status LIKE @Subject_Status)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TxtDate" Name="rpDate" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="Drop_Responsible" DefaultValue="" Name="Response_emp" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="Drop_Subject_Status" Name="Subject_Status" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="InvMonthDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>"
        SelectCommand="SELECT ID, DDate, Response_emp, Incoming_Type, Postal_Code, Authority, Emp_Number, Emp_Name, Subject, Subject_Content, In_Tashira, Out_Tashira, Incoming_From, Action_Taken, Aditional_Actions, Required_Time, Aditional_Tashira, Subject_Status, Notes, YEAR(DDate) AS Expr1, MONTH(DDate) AS Expr2, Subject_ID, Work_area, Followup3 FROM Inventory WHERE (YEAR(DDate) = YEAR(@rpDate)) AND (MONTH(DDate) = MONTH(@rpDate)) AND (Response_emp LIKE @Response_emp) AND (Work_area = @Work_area) AND (Subject_Status = @Subject_Status) OR (YEAR(DDate) = YEAR(@rpDate)) AND (MONTH(DDate) = MONTH(@rpDate)) AND (Response_emp LIKE @Response_emp) AND (Work_area = @Work_area) AND (Subject_Status LIKE @Subject_Status) OR (YEAR(DDate) = YEAR(@rpDate)) AND (MONTH(DDate) = MONTH(@rpDate)) AND (Response_emp LIKE @Response_emp) AND (Work_area = @Work_area) AND (Subject_Status = @Subject_Status) OR (YEAR(DDate) = YEAR(@rpDate)) AND (MONTH(DDate) = MONTH(@rpDate)) AND (Response_emp LIKE @Response_emp) AND (Work_area = @Work_area) AND (Subject_Status = @Subject_Status) AND (Authority = @Work_area) OR (YEAR(DDate) = YEAR(@rpDate)) AND (MONTH(DDate) = MONTH(@rpDate)) AND (Response_emp LIKE @Response_emp) AND (Work_area = @Work_area) AND (Subject_Status = @Subject_Status) AND (Incoming_From = @Work_area) ORDER BY DDate">
        <SelectParameters>
            <asp:ControlParameter ControlID="TxtDate" Name="rpDate" PropertyName="Text" Type="datetime" />
            <asp:ControlParameter ControlID="Drop_Responsible" Name="Response_emp" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="Work_area" SessionField="Work_Area" />
            <asp:ControlParameter ControlID="Drop_Subject_Status" Name="Subject_Status" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="InvDetailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>"
        SelectCommand="SELECT ID, DDate, Response_emp, Incoming_Type, Postal_Code, Authority, Emp_Number, Emp_Name, Subject, Subject_Content, In_Tashira, Out_Tashira, Incoming_From, Action_Taken, Aditional_Actions, Required_Time, Aditional_Tashira, Subject_Status, Notes, Subject_ID FROM Inventory WHERE (Subject_ID = @rpSubject_ID) AND (YEAR(DDate) = @DDate) ORDER BY DDate">
        <SelectParameters>
            <asp:ControlParameter ControlID="TxtSubjectID" DefaultValue="1" Name="rpSubject_ID" PropertyName="Text" />
            <asp:ControlParameter ControlID="DropSubject_Year" DefaultValue="" Name="DDate" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SubjectlDataSource_id" runat="server" ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>"
        SelectCommand="SELECT Subject_ID, DDate FROM Inventory WHERE (YEAR(DDate) = @DDate) ORDER BY Subject_ID + 0 DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropSubject_Year" Name="DDate" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Head_MonthDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>"
        SelectCommand="SELECT ID, Postal_Code, Action_Taken, Notes, YEAR(Moror_Date) AS Expr1, MONTH(Moror_Date) AS Expr2, Record_ID, Zone, OFCE_NAME, OFCE_ID, Manager_Name, Fellow_Name, Moror_Date, Moror_Time, Report_Notes, inform, FollowUp FROM Head_Sector WHERE (YEAR(Moror_Date) = YEAR(@rpDate)) AND (MONTH(Moror_Date) = MONTH(@rpDate)) ORDER BY Moror_Date">
        <SelectParameters>
            <asp:ControlParameter ControlID="TxtDate" Name="rpDate" PropertyName="Text" Type="datetime" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Files_MonthDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>"
        SelectCommand="SELECT ID, YEAR(DDate) AS Expr1, MONTH(DDate) AS Expr2, File_ID, File_Content, Response_emp, Notes, File_Subject, DDate FROM Files WHERE (YEAR(DDate) = YEAR(@rpDate)) AND (MONTH(DDate) = MONTH(@rpDate)) ORDER BY DDate">
        <SelectParameters>
            <asp:ControlParameter ControlID="TxtDate" Name="rpDate" PropertyName="Text" Type="datetime" />
        </SelectParameters>
    </asp:SqlDataSource>
                     <asp:SqlDataSource ID="ResponsibleSqlDataSource" runat="server" 
                         ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>" 
                         
                         SelectCommand="SELECT UsrName, PRMTION, Work_Area FROM USERS WHERE (PRMTION = 2) AND (Work_Area = @Work_Area) ORDER BY UsrName">
                         <SelectParameters>
                             <asp:SessionParameter Name="Work_Area" SessionField="Work_Area" />
                         </SelectParameters>
                     </asp:SqlDataSource>
    <asp:SqlDataSource ID="SubjectlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>"
        SelectCommand="SELECT DISTINCT YEAR(DDate) AS Date FROM Inventory ORDER BY Date DESC">
    </asp:SqlDataSource>
    </form>
</body>
</html>
