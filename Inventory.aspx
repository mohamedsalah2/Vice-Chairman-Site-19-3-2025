<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Inventory.aspx.vb" Inherits="Inventory" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="Cal/Styles/calendar-blue.css" rel="stylesheet" type="text/css" />
       <title>Inventory Management</title>

    <style type="text/css">
        .style15
        {
            font-weight: 700;
            font-style: italic;
            text-decoration: underline;
            font-size: xx-large;
        }

        .style16
        {
            width: 130px;
        }
    </style>
    <style type="text/css">
        .FixedHeader
        {
            position: absolute;
            font-weight: bold;
        }
    </style>
    <style type="text/css">
        .upper-case
        {
            text-transform: uppercase;
        }

        .style9
        {
            margin-right: 0px;
            direction: rtl;
        }

        .style6
        {
        }

        .auto-style1
        {
            width: 97%;
        }

        .auto-style2
        {
            margin-right: 0px;
            font-size: large;
        }

        .auto-style3
        {
            background-color: #9999FF;
        }

        .auto-style4
        {
            width: 130px;
            text-align: center;
        }

        .auto-style7
        {
            height: 32px;
        }

        .auto-style8
        {
            width: 130px;
            height: 32px;
        }

        .auto-style10
        {
            height: 32px;
            width: 82px;
        }

        .auto-style11
        {
            width: 82px;
            margin-right: 160px;
        }

        .auto-style12
        {
            height: 15px;
            width: 82px;
        }

        .auto-style13
        {
            height: 25px;
        }

        .auto-style14
        {
            width: 130px;
            height: 25px;
        }

        .auto-style15
        {
            width: 82px;
            height: 25px;
            margin-right: 160px;
        }

        .auto-style16
        {
            width: 330px;
        }

        .auto-style17
        {
            height: 32px;
            width: 330px;
        }

        .auto-style19
        {
            height: 25px;
            width: 330px;
        }

        .hiddenField
        {
            display: none;
        }

        /* Add CSS to style the popup and overlay */
        .popup-overlay
        {
            display: none; /* Hidden by default */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
            z-index: 999; /* Ensure it appears above other elements */
        }

        #pnlFilePopup
        {
            display: none; /* Initially hidden */
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000; /* Ensure the popup is above the overlay */
        }

            #pnlFilePopup .btn-delete
            {
                background-color: red;
                color: white;
            }
        /* Close button style */
        .btn-close
        {
            background-color: #ff4d4d; /* Red background */
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        /* Change button style */
        .btn-change
        {
            background-color: #4CAF50; /* Green background */
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        /* Delete button style */
        .btn-delete
        {
            background-color: #f44336; /* Red background */
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        /* Make sure buttons look good inside the panel */
        #pnlFilePopup
        {
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .auto-style20
        {
            height: 70px;
        }

        .auto-style21
        {
            width: 330px;
            height: 70px;
        }

        .auto-style22
        {
            width: 130px;
            height: 70px;
        }

        .auto-style23
        {
            height: 15px;
        }

        .auto-style24
        {
            width: 330px;
            height: 15px;
        }

        .auto-style25
        {
            width: 130px;
            height: 15px;
        }

        .auto-style26
        {
            width: 107px;
        }

        .auto-style27
        {
            width: 179px;
        }
        /* Progress Bar Container */
        #progressBar
        {
            width: 0%;
            height: 100%;
            background-color: #4caf50;
            transition: width 0.3s;
        }

        /* UpdateProgress Styling */
        .update-progress
        {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border: 1px solid #ccc;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" dir="rtl" style="background-color: #D2D2D2; height: auto; width: auto;">
        <div dir="rtl">
            <table align="center" style="margin-right: 0px;" dir="rtl" class="auto-style1">
                <tr>
                    <td align="center" class="style18">
                        <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/Main.aspx" Font-Bold="True"
                            Font-Size="18pt">الصفحة الرئيسية</asp:LinkButton>
                    </td>
                    <td align="center" class="style15" style="border-style: groove">
                        <asp:Label ID="Label23" runat="server" Text="موضوعات محور شئون المناطق" CssClass="style9" Font-Size="20pt"
                            Width="364px"></asp:Label>
                    </td>
                    <td align="center">&nbsp;</td>
                    <td align="center">
                        <asp:Button ID="ShowDate_BTN" runat="server" Text="ShowDate" Visible="False" Width="18px" Height="21px" />
                        <asp:TextBox ID="Txt_IPAddress" runat="server" Width="35px" CssClass="style9" Height="25px"
                            Font-Size="16pt" Enabled="False" Visible="False"></asp:TextBox>
                        <asp:TextBox ID="Txt_Password" runat="server" Width="75px" CssClass="style9" Height="25px"
                            Font-Size="16pt" Enabled="False" Visible="False"></asp:TextBox>
                    </td>
                    <td align="center">
                        <asp:LinkButton ID="LinkButton7" runat="server" PostBackUrl="~/Reports.aspx" Font-Bold="True"
                            Font-Size="18pt">التقارير</asp:LinkButton>
                    </td>
                </tr>
            </table>
            <table align="center" class="table table-striped" dir="rtl" width="100%"
                style="border-style: solid;" cellpadding="0" cellspacing="0">
                <tr style="border-style: solid">
                    <td class="style32" height="25">
                        <span class="dtcDisplayArea">
                            <asp:Label ID="Label22" runat="server" Text="التاريخ" CssClass="style9" Font-Size="15pt"
                                Width="100px" Font-Bold="True" Height="25px"></asp:Label>
                        </span>
                    </td>
                    <td class="auto-style16" height="25">
                        <span class="dtcDisplayArea" dir="rtl"><strong><span class="style35">
                            <script src="Cal/Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
                            <script src="Cal/Scripts/jquery.dynDateTime.min.js" type="text/javascript"></script>
                            <script src="Cal/Scripts/calendar-en.min.js" type="text/javascript"></script>
                            <script type="text/javascript">
                                $(document).ready(function () {
                                    $("#<%=TxtDate.ClientID %>").dynDateTime({
                                        Date: 'now',
                                        showsTime: true,
                                        timeFormat: "12",
                                        ifFormat: "%d/%m/%Y",     //the date format that will be used to display the date in displayArea 
                                        daFormat: "%e/%m/%Y",    //date format that will be stored in the input field 
                                        align: "BR",
                                        //          align: "TL",
                                        electric: true,
                                        singleClick: true,
                                        displayArea: ".siblings('.dtcDisplayArea')",
                                        button: ".next()",
                                        allowInputToggle: true

                                    });
                                });

                            </script>
                            <asp:TextBox ID="TxtDate" runat="server" Width="99px" Height="25px"
                                AutoPostBack="True"></asp:TextBox>
                            <img src="cal/calender.png" alt="Click to popup the bank window!" style="width: 20px; height: 26px; margin-top: 0px" /></span></strong></span>
                    </td>
                    <td class="auto-style4" height="25">&nbsp;
                    <strong>
                        <asp:Label ID="Label24" runat="server" Text="ID" CssClass="auto-style2" Font-Size="16pt"
                            Width="48px" Height="25px" ForeColor="Red"></asp:Label>
                    </strong>
                    </td>
                    <td class="auto-style27" height="25">
                        <asp:TextBox ID="Txt_SubjectID" runat="server" Width="63px" CssClass="style9" Height="25px"
                            Font-Size="16pt" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td class="style28" height="25">
                        <asp:Label ID="Label7" runat="server" Text="رقم الملف" CssClass="style9" Font-Size="15pt"
                            Width="70px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style26" height="25">
                        <asp:TextBox ID="Txt_EmpNo" runat="server" Width="64px" CssClass="style9" Height="25px"
                            Font-Size="15pt">0</asp:TextBox>
                    </td>
                    <td class="style28" height="25">&nbsp;</td>
                    <td class="auto-style3" style="border-style: double" height="25" colspan="2" dir="rtl">
                        <asp:TextBox ID="TxtSearch" runat="server" Width="208px" CssClass="style9" Height="25px"
                            Font-Size="15pt" onfocus="clearText(this)" onblur="restoreText(this)"
                            Text="*إكتب كلمه للبحث*"></asp:TextBox>

                        <script type="text/javascript">
                            function clearText(txt) {
                                if (txt.value === '*إكتب كلمه للبحث*') {
                                    txt.value = '';
                                }
                            }

                            function restoreText(txt) {
                                if (txt.value.trim() === '') {
                                    txt.value = '*إكتب كلمه للبحث*';
                                }
                            }
                        </script>

                        <asp:Button ID="Btn_Search" runat="server" Text="بحث" Style="font-family: 'Times New Roman', Times, serif; font-size: x-large; font-weight: 700;"
                            Width="94px" Height="30px" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">
                        <asp:Label ID="Label5" runat="server" Text="المسئول" CssClass="style9" Font-Size="15pt"
                            Width="100px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style17">
                        <asp:DropDownList ID="Drop_Responsible" runat="server" CssClass="style9" Width="175px" dir="rtl"
                            Font-Size="15pt" DataSourceID="ResponsibleSqlDataSource" DataTextField="UsrName" DataValueField="UsrName" Height="100%" Enabled="False">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style8">
                        <asp:Label ID="Label27" runat="server" Text="الموقع" CssClass="style9" Font-Size="14pt"
                            Width="102px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style7" colspan="3">
                        <asp:DropDownList ID="Work_Area" runat="server" CssClass="style9" Width="181px"
                            Font-Size="15pt" DataSourceID="Subject_RelateSqlDataSource" DataTextField="Work_Area" DataValueField="Work_Area" Height="25px" Enabled="False">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style10">
                        <asp:Label ID="Label9" runat="server" Text="رقم المسجل" CssClass="style9" Font-Size="15pt"
                            Width="100px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style7">
                        <asp:TextBox ID="Txt_PostalCode" runat="server" Width="210px" CssClass="upper-case"
                            Height="25px" Font-Size="15pt"></asp:TextBox>
                    </td>
                    <td class="auto-style7">
                        <asp:Button ID="Btn_Save" runat="server" Text="حفظ" Style="font-family: 'Times New Roman', Times, serif; font-size: x-large; font-weight: 700;"
                            Width="100px" Height="30px" />
                    </td>
                </tr>
                <tr>
                    <td class="style32">
                        <asp:Label ID="Label6" runat="server" Text="الموضوع" CssClass="style9" Font-Size="15pt"
                            Width="100px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style16">
                        <asp:DropDownList ID="Drop_Subject" runat="server" CssClass="style9" Width="175px"
                            Font-Size="15pt" Height="100%">
                            <asp:ListItem Value="مذكره" Selected="True">مذكره</asp:ListItem>
                            <asp:ListItem Value="التماس">التماس</asp:ListItem>
                            <asp:ListItem Value="مكاتبه">مكاتبه</asp:ListItem>
                            <asp:ListItem Value="شكوي عميل">شكوي عميل</asp:ListItem>
                            <asp:ListItem Value="تقرير مرور">تقرير مرور</asp:ListItem>
                            <asp:ListItem>مقابله</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="style16">
                        <asp:Label ID="Label4" runat="server" Text="وارد بواسطه" CssClass="style9" Font-Size="15pt"
                            Width="91px" Height="25px"></asp:Label>
                    </td>
                    <td class="style28" colspan="3">
                        <asp:DropDownList ID="Drop_IncomType" runat="server" Style="margin-right: 0px;" Height="100%"
                            Width="130px" CssClass="style9" Font-Size="15pt">
                            <asp:ListItem Value="الايميل">الايميل</asp:ListItem>
                            <asp:ListItem Value="البريد">البريد</asp:ListItem>
                            <asp:ListItem Value="اليد">اليد</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style11">
                        <asp:Label ID="Label19" runat="server" Text="الاسم" CssClass="style9" Font-Size="15pt"
                            Width="100px" Height="25px"></asp:Label>
                    </td>
                    <td class="style30" colspan="2">
                        <asp:TextBox ID="Txt_EmpName" runat="server" Width="210px" CssClass="style9" Height="25px"
                            Font-Size="15pt"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style20">
                        <asp:Label ID="Label12" runat="server" Text="الجهه" CssClass="style9" Font-Size="15pt"
                            Width="100px" Font-Bold="True" ForeColor="Red"></asp:Label>
                    </td>
                    <td class="auto-style21">
                        <input list="authorityList" id="Drop_Authority" name="Drop_Authority" class="style9" style="width: 290px; font-size: 15pt; height: 48%;" dir="rtl" />
                        <datalist id="authorityList">
                                <option value="القطاع القانوني" />
                                <option value="قطاع الامن" />
                                <option value="شرق الدلتا" />
                                <option value="الجيزه" />
                                <option value="مصر الوسطي" />
                                <option value="غرب الدلتا" />
                                <option value="شمال الدلتا" />
                                <option value="وسط الدلتا" />
                                <option value="مصر العليا" />
                                <option value="المبيعات" />
                                <option value="الانشطه الداعمه" />
                        </datalist>
                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                var dropAuthority = document.getElementById("Drop_Authority");
                                var txtAuthority = document.getElementById("<%= Txt_Authority.ClientID %>");

                                dropAuthority.addEventListener("change", function () {
                                    var valid = false;
                                    var dataList = document.getElementById("authorityList").options;

                                    for (var i = 0; i < dataList.length; i++) {
                                        if (dropAuthority.value === dataList[i].value) {
                                            valid = true;
                                            break;
                                        }
                                    }

                                    if (!valid) {
                                        alert("⚠ الرجاء اختيار قيمة صحيحة من القائمة فقط!");
                                        dropAuthority.value = ""; // تفريغ الحقل إذا كان الإدخال غير صحيح
                                        txtAuthority.value = "";
                                    } else {
                                        txtAuthority.value = dropAuthority.value;
                                    }
                                });
                            });
                        </script>
                        <asp:TextBox ID="Txt_Authority" runat="server" Width="198px" CssClass="hiddenField" Height="16px"
                            Font-Size="13pt" TextMode="MultiLine"></asp:TextBox>
                    </td>
                    <td class="auto-style22">
                        <asp:Label ID="Label10" runat="server" Text="نص الموضوع" CssClass="style9" Font-Size="15pt"
                            Font-Bold="True" Width="94px" ForeColor="Red"></asp:Label>
                    </td>
                    <td colspan="6" dir="rtl" class="auto-style20">
                        <asp:TextBox ID="Txt_Subject" runat="server" Width="712px" CssClass="style9" Height="65px"
                            Font-Size="13pt" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style23" dir="rtl">
                        <asp:Label ID="Label11" runat="server" Text="التاشيرة" CssClass="style9"
                            Font-Size="15pt" Width="100px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style24" dir="rtl">
                        <asp:TextBox ID="Txt_InTashira" runat="server" Width="290px" CssClass="style9" Height="27px"
                            Font-Size="12pt"></asp:TextBox>
                    </td>
                    <td class="auto-style25" dir="rtl">
                        <asp:Label ID="Label1" runat="server" Text="تحديث المتابعة" CssClass="style9" Font-Size="15pt"
                            Width="109px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style23" colspan="3" dir="rtl">
                        <asp:TextBox ID="Txt_OutTashira" runat="server" Width="260px" CssClass="style9" Height="25px"
                            Font-Size="12pt"></asp:TextBox>
                        .</td>
                    <td class="auto-style12" dir="rtl">
                        <asp:Label ID="Label18" runat="server" Text="ملاحظات" CssClass="style9" Font-Size="15pt"
                            Width="100px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style23" colspan="2" dir="rtl">
                        <asp:TextBox ID="Txt_Notes" runat="server" Width="210px" CssClass="style9" Height="25px"
                            Font-Size="15pt"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style13">
                        <asp:Label ID="Label13" runat="server" Text="الاجراء المتخذ" CssClass="style9" Font-Size="15pt"
                            Width="100px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style19">
                        <asp:TextBox ID="Txt_Action_Taken" runat="server" Width="290px" CssClass="style9"
                            Height="25px" Font-Size="15pt"></asp:TextBox>
                    </td>
                    <td class="auto-style14">
                        <asp:Label ID="Label16" runat="server" Text="تحديث المتابعة 2 " CssClass="style9" Font-Size="15pt"
                            Width="116px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style13" colspan="3">
                        <asp:TextBox ID="Txt_Aditional_Tashira" runat="server" Width="260px" CssClass="style9"
                            Height="25px" Font-Size="15pt"></asp:TextBox>
                    </td>
                    <td class="auto-style15">
                        <asp:Label ID="Label14" runat="server" Text="اجراءات اضافية" CssClass="style9" Font-Size="15pt"
                            Width="105px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style13" colspan="2">
                        <asp:DropDownList ID="Drop_Aditional_Actions" runat="server" CssClass="style9" Width="130px"
                            Font-Size="15pt" Height="100%">
                            <asp:ListItem Value="جاري المتابعه" Selected="True">جاري المتابعه</asp:ListItem>
                            <asp:ListItem Value="استعجال 1">استعجال 1</asp:ListItem>
                            <asp:ListItem Value="استعجال 2">استعجال 2</asp:ListItem>
                            <asp:ListItem Value="استعجال 3">استعجال 3</asp:ListItem>
                            <asp:ListItem Value="تم تحويله للتفتيش">تم تحويله للتفتيش</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="style32" height="25">
                        <asp:Label ID="Label3" runat="server" Text="وارد من" CssClass="style9" Font-Size="15pt"
                            Width="104px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style16" height="25">
                        <asp:TextBox ID="TXT_incoming_From" runat="server" CssClass="hiddenField"
                            Width="165px" Height="25px" Font-Size="15pt"></asp:TextBox>

                        <input list="incomingList" id="Drop_Incoming" name="Drop_Incoming" class="style9"
                            style="width: 290px; font-size: 15pt; height: 85%;" dir="rtl" />
                        <datalist id="incomingList">
    <option value="القطاع القانوني" />
    <option value="قطاع الامن" />
    <option value="شرق الدلتا" />
    <option value="الجيزه" />
    <option value="مصر الوسطي" />
    <option value="غرب الدلتا" />
    <option value="شمال الدلتا" />
    <option value="وسط الدلتا" />
    <option value="مصر العليا" />
    <option value="المبيعات" />
    <option value="الانشطه الداعمه" />
</datalist>

                        <script>
                            function updateTextBox() {
                                // Get the selected value from the <input> element
                                var selectedValue = document.getElementById("Drop_Incoming").value;

                                // Set the value to the TextBox
                                document.getElementById("<%= TXT_incoming_From.ClientID%>").value = selectedValue;
                            }

                            // Attach the function to the input's change event
                            document.getElementById("Drop_Incoming").addEventListener("change", updateTextBox);
                        </script>
                    </td>
                    <td class="style16" height="25">
                        <asp:Label ID="Label26" runat="server" Text="تحديث المتابعة 3" CssClass="style9" Font-Size="15pt"
                            Width="120px" Height="25px"></asp:Label>
                    </td>
                    <td class="style28" height="25" colspan="3">
                        <asp:TextBox ID="Followup3" runat="server" Width="260px" CssClass="style9" Height="25px"
                            Font-Size="12pt"></asp:TextBox>
                    </td>
                    <td class="auto-style11" height="25">
                        <asp:Label ID="Label20" runat="server" Text="موقف الموضوع" CssClass="style9" Font-Size="14pt"
                            Width="102px" Height="25px"></asp:Label>
                    </td>
                    <td class="style30" height="25" colspan="2">
                        <asp:DropDownList ID="Drop_Subject_Status" runat="server" CssClass="style9" Width="130px"
                            Font-Size="15pt" Height="100%">
                            <asp:ListItem Value="الموضوع مفتوح" Selected="True">الموضوع مفتوح</asp:ListItem>
                            <asp:ListItem Value="تم غلق الموضوع">تم غلق الموضوع</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style13">
                        <asp:Label ID="Label25" runat="server" Text="المرفقات" CssClass="style9" Font-Size="15pt"
                            Width="100px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style19">
                        <!-- Updated section for multiple file uploads in Inventory.aspx -->
                        <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="true" Width="290px" />
                        <asp:TextBox ID="Txt_Attach1" runat="server" TextMode="MultiLine" Rows="5" Width="22px" Visible="False" Height="16px"></asp:TextBox>
                    </td>
                    <td class="auto-style14">&nbsp;</td>
                    <td class="auto-style13" colspan="3">&nbsp;</td>
                    <td class="auto-style15">
                        <asp:Label ID="Label15" runat="server" Text="الوقت المطلوب" CssClass="style9" Font-Size="15pt"
                            Width="100px" Height="25px"></asp:Label>
                    </td>
                    <td class="auto-style13">
                        <asp:DropDownList ID="Drop_Time" runat="server" CssClass="style9" Width="130px"
                            Font-Size="15pt" Height="90%">
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>7</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                            <asp:ListItem Selected="True">بدون وقت</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="Txt_Required_Time" runat="server" Width="40px" CssClass="style9"
                            Height="19px" Font-Size="15pt" Visible="False"></asp:TextBox>
                    </td>
                    <td class="auto-style13">&nbsp;</td>
                </tr>
            </table>

            <!--  Function to Multi file download -->

            <script type="text/javascript">
                function downloadFiles(fileUrls) {
                    var urls = fileUrls.split(','); // Split URLs by commas
                    var delay = 100; // Delay in milliseconds between downloads

                    if (urls.length === 0) {
                        console.error("No URLs provided for download.");
                        return;
                    }

                    urls.forEach(function (url, index) {
                        setTimeout(function () {
                            var xhr = new XMLHttpRequest();
                            xhr.open("GET", url.trim(), true);
                            xhr.responseType = "blob"; // Expect a binary response

                            xhr.onload = function () {
                                if (xhr.status === 200) {
                                    var blob = xhr.response;
                                    var link = document.createElement('a');
                                    var fileName = decodeURIComponent(url.split('/').pop() || 'download');

                                    if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                                        // For IE and Edge (legacy versions)
                                        window.navigator.msSaveOrOpenBlob(blob, fileName);
                                    } else {
                                        // For other browsers
                                        var objectUrl = URL.createObjectURL(blob);
                                        link.href = objectUrl;
                                        link.download = fileName;
                                        document.body.appendChild(link);
                                        link.click();
                                        document.body.removeChild(link);
                                        URL.revokeObjectURL(objectUrl); // Clean up
                                    }
                                    console.log("Downloaded:", fileName);
                                } else {
                                    console.error("Failed to fetch file at", url, "(Status:", xhr.status, ")");
                                }
                            };
                            xhr.onerror = function () {
                                console.error("Network error while fetching file:", url);
                            };
                            xhr.send();
                        }, index * delay); // Apply delay between downloads
                    });
                }
            </script>

            <!--  section for multiple  file download -->
            <div id="Div1" style="display: none;">
                <asp:Label ID="Label2" runat="server" Text="Select files to download:" />
                <asp:CheckBoxList ID="CheckBoxList1" runat="server" RepeatDirection="Vertical" />
                <asp:Button ID="Button1" runat="server" Text="Download Selected" OnClick="btnDownloadSelectedPopup_Click" />
            </div>
            <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <div class="popup-overlay"></div>

            <!-- File Upload Popup -->
            <!-- Place ScriptManager at the top, outside any UpdatePanel -->


            <!--  section for multiple  file download -->

            <div id="Div2" style="display: none;">
                <asp:Label ID="Label8" runat="server" Text="Select files to download:" />
                <asp:CheckBoxList ID="CheckBoxList2" runat="server" RepeatDirection="Vertical" />
                <asp:Button ID="Button2" runat="server" Text="Download Selected" OnClick="btnDownloadSelectedPopup_Click" />
            </div>

            <!-- File Upload Popup -->
            <asp:Panel ID="pnlFilePopup" runat="server" Style="display: none;" background BackColor="#fff7e7">

                <asp:Label ID="lblFileList" runat="server" Text="Select files to download or delete:" />
                <asp:CheckBoxList ID="cblFileListPopup" runat="server" RepeatDirection="Vertical" />
                <asp:RadioButtonList ID="rblDownloadOption" runat="server">
                    <asp:ListItem Text="Download as Zip" Value="Zip" />
                    <asp:ListItem Text="Download Individual Files" Value="Individual" Selected="True" />
                </asp:RadioButtonList>
                <br />
                <asp:Button ID="btnDownloadSelectedPopup" runat="server" Text="Download Selected" OnClick="btnDownloadSelectedPopup_Click" />
                <asp:Button ID="btnDeleteSelectedPopup" runat="server" Text="Delete Selected" OnClick="btnDeleteSelectedPopup_Click" CssClass="btn-delete" />
                <br />
                <!-- File Upload Controls -->
                <asp:FileUpload ID="FileUploadMulti" runat="server" AllowMultiple="true" />
                <asp:Button ID="btnUploadFiles" runat="server" Text="Upload Files" OnClick="btnUploadFiles_Click" />
                <br />
                <asp:HiddenField ID="HiddenFieldRecordID" runat="server" />
                <!-- Close Button -->
                <asp:Button ID="btnClosePopup" runat="server" Text="Close" OnClick="btnClosePopup_Click" CssClass="btn-change" />
            </asp:Panel>
            <!-- Edit Row Popup -->
            <asp:Panel ID="pnlEditPopup" runat="server" CssClass="popup-overlay" Style="display: none;">
                <div style="background: white; padding: 15px; width: 800px; margin: 50px auto; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 8px;">
                        <h3 style="margin: 0; color: #333; font-size: 16px;">تعديل البيانات</h3>
                        <asp:Button ID="btnCancelEdit" runat="server" Text="إلغاء" CssClass="btn btn-secondary" OnClick="btnCancelEdit_Click" Style="padding: 4px 8px; font-size: 12px;" />
                    </div>
                    <asp:HiddenField ID="HiddenFieldEditRecordID" runat="server" />
                    <div style="max-height: 60vh; overflow-y: auto;">
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                            <!-- Left Column - Basic Information -->
                            <div>
                                <h4 style="margin: 0 0 10px 0; font-size: 14px; color: #333; border-bottom: 1px solid #eee; padding-bottom: 5px;">المعلومات الأساسية</h4>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">وارد بواسطه</label>
                                    <asp:TextBox ID="txtEditIncomingType" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">رقم المسجل</label>
                                    <asp:TextBox ID="txtEditPostalCode" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">الجهة</label>
                                    <input type="text" id="txtEditAuthority" runat="server" class="form-control" list="AuthorityList" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">رقم الملف</label>
                                    <asp:TextBox ID="txtEditEmpNumber" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">الاسم</label>
                                    <asp:TextBox ID="txtEditEmpName" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">الموضوع</label>
                                    <asp:TextBox ID="txtEditSubject" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                            </div>

                            <!-- Right Column - Subject Details -->
                            <div>
                                <h4 style="margin: 0 0 10px 0; font-size: 14px; color: #333; border-bottom: 1px solid #eee; padding-bottom: 5px;">تفاصيل الموضوع</h4>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">نص الموضوع</label>
                                    <asp:TextBox ID="txtEditSubjectContent" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" Style="font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">وارد من</label>
                                    <input type="text" id="txtEditIncomingFrom" runat="server" class="form-control" list="IncomingFromList" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">الاجراء المتخذ</label>
                                    <asp:TextBox ID="txtEditActionTaken" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">اجراءات اضافية</label>
                                    <asp:TextBox ID="txtEditAditionalActions" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                            </div>

                            <!-- Left Column - Follow-up Information -->
                            <div>
                                <h4 style="margin: 0 0 10px 0; font-size: 14px; color: #333; border-bottom: 1px solid #eee; padding-bottom: 5px;">معلومات المتابعة</h4>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">التاشيرة</label>
                                    <asp:TextBox ID="txtEditInTashira" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">تحديث المتابعة</label>
                                    <asp:TextBox ID="txtEditOutTashira" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">تحديث المتابعة 2</label>
                                    <asp:TextBox ID="txtEditAditionalTashira" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">تحديث المتابعة 3</label>
                                    <asp:TextBox ID="txtEditFollowup3" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                            </div>

                            <!-- Right Column - Status and Notes -->
                            <div>
                                <h4 style="margin: 0 0 10px 0; font-size: 14px; color: #333; border-bottom: 1px solid #eee; padding-bottom: 5px;">الحالة والملاحظات</h4>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">الوقت المطلوب</label>
                                    <asp:TextBox ID="txtEditRequiredTime" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">موقف الموضوع</label>
                                    <asp:TextBox ID="txtEditSubjectStatus" runat="server" CssClass="form-control" Style="height: 25px; font-size: 12px;" />
                                </div>
                                <div style="margin-bottom: 8px;">
                                    <label style="display: block; margin-bottom: 2px; font-size: 12px;">ملاحظات</label>
                                    <asp:TextBox ID="txtEditNotes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" Style="font-size: 12px;" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: left; margin-top: 15px; border-top: 1px solid #eee; padding-top: 8px;">
                        <asp:Button ID="btnSaveEdit" runat="server" Text="حفظ" CssClass="btn btn-primary" OnClick="btnSaveEdit_Click" Style="padding: 4px 8px; font-size: 12px;" />
                    </div>
                </div>
            </asp:Panel>
            <!-- HiddenField to store the ID of the row being edited.   -->
            <asp:HiddenField ID="HiddenField2" runat="server" />
<script type="text/javascript">
    function showEditPopup(rowID) {
        // Hide any existing popups first
        document.getElementById('<%= pnlFilePopup.ClientID %>').style.display = 'none';
        document.querySelector('.popup-overlay').style.display = 'none';
        
        // Set the row ID in the hidden field
        document.getElementById('<%= HiddenFieldEditRecordID.ClientID%>').value = rowID;

        // Show the edit popup
        document.getElementById('<%= pnlEditPopup.ClientID %>').style.display = 'block';
        document.querySelector('.popup-overlay').style.display = 'block';
    }

    function closeEditPopup() {
        // Hide the edit popup and overlay
        document.getElementById('<%= pnlEditPopup.ClientID %>').style.display = 'none';
        document.querySelector('.popup-overlay').style.display = 'none';
    }

    function showFilePopup() {
        // Hide any existing popups first
        document.getElementById('<%= pnlEditPopup.ClientID %>').style.display = 'none';
        
        // Show the file popup
        document.getElementById('<%= pnlFilePopup.ClientID %>').style.display = 'block';
        document.querySelector('.popup-overlay').style.display = 'block';
    }

    function closeFilePopup() {
        // Hide the file popup and overlay
        document.getElementById('<%= pnlFilePopup.ClientID %>').style.display = 'none';
        document.querySelector('.popup-overlay').style.display = 'none';
    }

    // Add event listeners for the close buttons
    document.addEventListener('DOMContentLoaded', function() {
        var btnClosePopup = document.getElementById('<%= btnClosePopup.ClientID %>');
        var btnCancelEdit = document.getElementById('<%= btnCancelEdit.ClientID %>');
        
        if (btnClosePopup) {
            btnClosePopup.onclick = function(e) {
                e.preventDefault();
                closeFilePopup();
            };
        }
        
        if (btnCancelEdit) {
            btnCancelEdit.onclick = function(e) {
                e.preventDefault();
                closeEditPopup();
            };
        }
    });
</script>
            <div id="grdCharges" runat="server" style="width: 100%; overflow: auto; height: 500px; margin-bottom: 65px;"
                dir="rtl">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None"
                    BorderWidth="1px" CellPadding="1" CellSpacing="1" Style="font-family: 'Times New Roman', Times, serif; font-size: x-large; margin-top: 0PX; margin-left: 0px; text-align: center; margin-right: 0px; margin-bottom: 9px;"
                    EmptyDataText="لا يوجد بيانات" ShowHeaderWhenEmpty="True"
                    Font-Names="Times New Roman" Font-Size="Medium" DataKeyNames="ID" DataSourceID="Entry_DataSource"
                    Height="100%" Width="100%" HorizontalAlign="Center" HeaderStyle-CssClass="30"
                    HeaderStyle-BackColor="YellowGreen" HeaderStyle-Font-Underline="False"
                    OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" SelectImageUrl="~/Images/Select.gif" SelectText="." />
                        <asp:BoundField DataField="ID" ReadOnly="True" HeaderText="ID" SortExpression="ID"
                            Visible="False"></asp:BoundField>
                        <asp:BoundField HeaderText="ID" DataField="Subject_ID" ReadOnly="True" />
                        <asp:BoundField DataField="Response_emp" HeaderText="المسئول" SortExpression="Response_emp">
                            <ControlStyle Width="90px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Incoming_Type" HeaderText="وارد بواسطه"
                            SortExpression="Incoming_Type" />
                        <asp:BoundField DataField="Postal_Code" HeaderText="رقم المسجل" SortExpression="Postal_Code" />
                        <asp:BoundField DataField="Authority" HeaderText="الجهة" SortExpression="Authority">
                            <ItemStyle Width="30px" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Emp_Number" HeaderText="رقم الملف" SortExpression="Emp_Number"
                            ReadOnly="True">
                            <ItemStyle Width="30px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Emp_Name" HeaderText="الاسم_______________"
                            SortExpression="Emp_Name">
                            <ControlStyle Width="50px" />
                            <HeaderStyle Wrap="False" Font-Underline="False" />
                            <ItemStyle Width="30px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DDate" HeaderText="التاريخ" SortExpression="DDate" Visible="False" />
                        <asp:BoundField DataField="Subject" HeaderText="الموضوع" SortExpression="Subject">
                            <ItemStyle Width="30px" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="نص الموضوع                              .">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Subject_Content") %>' Style="white-space: nowrap; overflow: hidden;"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Subject_Content") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="300px" Wrap="False"></HeaderStyle>
                            <ItemStyle Width="300" HorizontalAlign="Justify" Wrap="True" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="التاشيرة                              ." DataField="In_Tashira" SortExpression="In_Tashira"
                            ItemStyle-Width="160px">
                            <FooterStyle Wrap="True" />
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Width="260px" Wrap="true"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField HeaderText="تحديث المتابعه" DataField="Out_Tashira" SortExpression="Out_Tashira">
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="تحديث المتابعه 2" DataField="Aditional_Tashira" SortExpression="Aditional_Tashira" />
                        <asp:BoundField DataField="Followup3" HeaderText="تحديث المتابعه 3" SortExpression="Followup3" />
                        <asp:BoundField HeaderText="وارد من" DataField="Incoming_From" SortExpression="Incoming_From" />
                        <asp:BoundField HeaderText="الاجراء المتخذ" DataField="Action_Taken" SortExpression="Action_Taken">
                            <ItemStyle Wrap="True" />
                        </asp:BoundField>
                        <asp:BoundField HeaderText="اجراءات اضافية" DataField="Aditional_Actions" SortExpression="Aditional_Actions" />
                        <asp:BoundField HeaderText="الوقت المطلوب" DataField="Required_Time" SortExpression="Required_Time" />
                        <asp:BoundField HeaderText="موقف الموضوع" DataField="Subject_Status" SortExpression="Subject_Status" />
                        <asp:BoundField HeaderText="ملاحظات" DataField="Notes" SortExpression="Notes" />
                        <asp:TemplateField HeaderText="المرفقات" SortExpression="Attach1">
                            <EditItemTemplate>
                                <!-- FileUpload for Attach1 in Edit Mode -->
                                <!-- HiddenField to store the existing Attach1 value -->
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("Attach1") %>' />
                                <!-- Label to display the current file name -->
                                <asp:Label ID="Label_Attach1" runat="server" Text='<%# Bind("Attach1") %>' />
                                <!-- Upload button (visible only when Attach1 is empty) -->
                                <asp:LinkButton ID="LinkButton_Upload" runat="server" Text="رفع المرفقات"
                                    CommandName="Upload"
                                    CommandArgument='<%# Container.DataItemIndex %>'
                                    Visible='<%# String.IsNullOrEmpty(Eval("Attach1").ToString()) %>' />
                                <!-- Delete button (visible only when Attach1 is not empty) -->
                                <asp:LinkButton ID="LinkButton_DeleteAttach" runat="server" Text="حذف المرفق"
                                    CommandName="DeleteAttachment"
                                    CommandArgument='<%# Eval("Attach1") %>'
                                    Visible='<%# Not String.IsNullOrEmpty(Eval("Attach1").ToString()) %>'
                                    OnClientClick="return confirm('هل أنت متأكد من حذف المرفق؟');">
                                </asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <!-- Label for displaying existing file in normal mode -->
                                <asp:Label ID="Label_Attach1" runat="server" Text='<%# Bind("Attach1") %>'
                                    Visible="False" />
                                <!-- Download button (visible only when Attach1 is not empty) -->
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/attach.png"
                                    Width="26px" Height="16px" CommandName="Download"
                                    CommandArgument='<%# Eval("Attach1") %>'
                                    Visible='<%# Not String.IsNullOrEmpty(Eval("Attach1").ToString()) %>' />
                                <!-- Upload button (visible only when Attach1 is empty) -->
                                <asp:LinkButton ID="LinkButton_Upload" runat="server" Text="رفع المرفقات"
                                    CommandName="Upload"
                                    CommandArgument='<%# Container.DataItemIndex %>'
                                    Visible='<%# String.IsNullOrEmpty(Eval("Attach1").ToString()) %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True" CommandName="Update"
                                    OnClientClick="return confirm('هل انت متأكد من  تحديث البيانات؟'); " Text="تحديث"></asp:LinkButton>
                                &nbsp;<asp:LinkButton ID="LinkButton5" runat="server" CausesValidation="False" CommandName="Cancel"
                                    Text="الغاء"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton6" runat="server" CausesValidation="False" CommandName="EditRow" 
                                    OnClientClick='<%# "showEditPopup(" + Eval("ID").ToString() + "); return false;" %>'
                                    Text="تعديل"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton
                                    ID="LinkButton4"
                                    runat="server"
                                    CausesValidation="False"
                                    CommandName="Delete"
                                    Text="حذف"
                                    OnClientClick="return confirmDelete();">
                                </asp:LinkButton>
                                <script type="text/javascript">
                                    function confirmDelete(linkButton) {
                                        var password = prompt("الرجاء إدخال كلمة المرور لتأكيد الحذف:");
                                        if (password === null) {
                                            return false; // Cancel if the user presses cancel
                                        }

                                        // Send password to server for verification using AJAX
                                        var isValid = false;
                                        $.ajax({
                                            type: "POST",
                                            url: "inventory.aspx/CheckPasswordAndPermission",
                                            data: JSON.stringify({ userPassword: password }),
                                            contentType: "application/json; charset=utf-8",
                                            dataType: "json",
                                            async: false,  // Wait for server response before proceeding
                                            success: function (response) {
                                                isValid = response.d;
                                            },
                                            error: function () {
                                                alert("خطأ في التحقق من كلمة المرور.");
                                            }
                                        });

                                        if (!isValid) {
                                            alert("كلمة المرور غير صحيحة، لا يمكنك الحذف.");
                                            return false;
                                        }

                                        return confirm("هل أنت متأكد من حذف البيانات؟ لا يمكن الرجوع");
                                    }
                                </script>

                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle Font-Size="Medium" CssClass="GridViewEditRow" />
                    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" Font-Size="Medium"
                        VerticalAlign="Middle" HorizontalAlign="Center" CssClass="30" />
                    <PagerSettings Mode="NumericFirstLast" />
                    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Right" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" Font-Size="Medium" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FFF1D4" />
                    <SortedAscendingHeaderStyle BackColor="#B95C30" />
                    <SortedDescendingCellStyle BackColor="#F1E5CE" />
                    <SortedDescendingHeaderStyle BackColor="#93451F" />
                </asp:GridView>
            </div>

            <asp:SqlDataSource ID="InvSearch" runat="server"
                ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>"
                SelectCommand="SELECT ID, DDate, Response_emp, Incoming_Type, Postal_Code, Authority, Emp_Number, Emp_Name, Subject_ID, Subject, Subject_Content, In_Tashira, Out_Tashira, Action_Taken, Aditional_Actions, Required_Time, Aditional_Tashira, Subject_Status, Notes, Attach1, Followup3, Incoming_From, Work_area FROM Inventory WHERE (CHARINDEX(@Subject_Content, Subject_Content) &gt; 0) OR (CHARINDEX(@Emp_Name, Emp_Name) &gt; 0) ORDER BY ID DESC"
                DeleteCommand="DELETE FROM [dbo].[Inventory]  WHERE [ID] = @ID">
                <DeleteParameters>
                    <asp:Parameter Name="ID" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="TxtSearch" Name="Subject_Content"
                        PropertyName="Text" />
                    <asp:ControlParameter ControlID="TxtSearch" Name="Emp_Name" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource
                ID="ResponsibleSqlDataSource"
                runat="server"
                ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>"
                SelectCommand="SELECT DISTINCT UsrName, Work_Area, PRMTION 
                   FROM USERS 
WHERE Work_Area &lt;&gt; '' 
AND (PRMTION = 2 OR (PRMTION = 1 AND Work_Area = @Work_Area))">
                <SelectParameters>
                    <asp:SessionParameter Name="Work_Area" SessionField="work_area" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="Subject_RelateSqlDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>"
                SelectCommand="SELECT DISTINCT Work_Area FROM USERS WHERE (Work_Area &lt;&gt; '') ORDER BY Work_Area"></asp:SqlDataSource>
            <asp:SqlDataSource ID="Entry_DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:Post_DBConnectionString %>"
                SelectCommand="SELECT ID, Subject_ID, DDate, Response_emp, Incoming_Type, Postal_Code, Authority, Emp_Number, Emp_Name, Subject, Subject_Content, In_Tashira, Out_Tashira, Incoming_From, Action_Taken, Aditional_Actions, Required_Time, Aditional_Tashira, Subject_Status, Notes, Attach1, Followup3, Work_area FROM Inventory WHERE (DDate = @DDATE) AND (Work_area = @Work_area) OR (DDate = @DDATE) AND (Authority = @Work_area) OR (DDate = @DDATE) AND (Incoming_From = @Work_area) OR (DDate = @DDATE) AND (Response_emp = @Response_emp) ORDER BY ID DESC"
                DeleteCommand="DELETE FROM Inventory WHERE  (ID = @ID)" UpdateCommand="UPDATE Inventory SET Response_emp = @Response_emp, Postal_Code = @Postal_Code, Authority = @Authority, Emp_Number = @Emp_Number, Emp_Name = @Emp_Name, Subject = @Subject, Subject_Content = @Subject_Content, In_Tashira = @In_Tashira, Out_Tashira = @Out_Tashira, Incoming_From = @Incoming_From, Action_Taken = @Action_Taken, Aditional_Actions = @Aditional_Actions, Required_Time = @Required_Time, Aditional_Tashira = @Aditional_Tashira, Subject_Status = @Subject_Status, Notes = @Notes, Attach1 = @Attach1, Followup3 = @Followup3 WHERE (ID = @ID)">
                <DeleteParameters>
                    <asp:Parameter Name="ID" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="TxtDate" Name="DDATE" PropertyName="Text" Type="DateTime" />
                    <asp:ControlParameter ControlID="Work_Area" Name="Work_area" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="Drop_Responsible" Name="Response_emp" PropertyName="SelectedValue" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Response_emp" />
                    <asp:Parameter Name="Postal_Code" />
                    <asp:Parameter Name="Authority" />
                    <asp:Parameter Name="Emp_Number" />
                    <asp:Parameter Name="Emp_Name" />
                    <asp:Parameter Name="Subject" />
                    <asp:Parameter Name="Subject_Content" />
                    <asp:Parameter Name="In_Tashira" />
                    <asp:Parameter Name="Out_Tashira" />
                    <asp:Parameter Name="Incoming_From" />
                    <asp:Parameter Name="Action_Taken" />
                    <asp:Parameter Name="Aditional_Actions" />
                    <asp:Parameter Name="Required_Time" />
                    <asp:Parameter Name="Aditional_Tashira" />
                    <asp:Parameter Name="Subject_Status" />
                    <asp:Parameter Name="Notes" />
                    <asp:Parameter Name="Attach1" />
                    <asp:Parameter Name="Followup3" />
                    <asp:Parameter Name="ID" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
