// Search text box functions
function clearText(txt) {
    if (txt && txt.value === '*إكتب كلمه للبحث*') {
        txt.value = '';
    }
}

function restoreText(txt) {
    if (txt && txt.value.trim() === '') {
        txt.value = '*إكتب كلمه للبحث*';
    }
}

// Authority dropdown validation
document.addEventListener("DOMContentLoaded", function () {
    var dropAuthority = document.getElementById("Drop_Authority");
    var txtAuthority = document.getElementById("<%= Txt_Authority.ClientID %>");

    if (dropAuthority && txtAuthority) {
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
                dropAuthority.value = "";
                txtAuthority.value = "";
            } else {
                txtAuthority.value = dropAuthority.value;
            }
        });
    }

    // Initialize incoming dropdown
    var dropIncoming = document.getElementById("Drop_Incoming");
    if (dropIncoming) {
        dropIncoming.addEventListener("change", function() {
            var selectedValue = this.value;
            var txtIncomingFrom = document.getElementById("<%= TXT_incoming_From.ClientID%>");
            if (txtIncomingFrom) {
                txtIncomingFrom.value = selectedValue;
            }
        });
    }
});

// File download functions
function downloadFiles(fileUrls) {
    if (!fileUrls) {
        console.error("No URLs provided for download.");
        return;
    }

    var urls = fileUrls.split(',');
    var delay = 100;

    if (urls.length === 0) {
        console.error("No URLs provided for download.");
        return;
    }

    urls.forEach(function (url, index) {
        setTimeout(function () {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", url.trim(), true);
            xhr.responseType = "blob";

            xhr.onload = function () {
                if (xhr.status === 200) {
                    var blob = xhr.response;
                    var link = document.createElement('a');
                    var fileName = decodeURIComponent(url.split('/').pop() || 'download');

                    if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                        window.navigator.msSaveOrOpenBlob(blob, fileName);
                    } else {
                        var objectUrl = URL.createObjectURL(blob);
                        link.href = objectUrl;
                        link.download = fileName;
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link);
                        URL.revokeObjectURL(objectUrl);
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
        }, index * delay);
    });
}

// Edit popup functions
function handleEditClick(recordId) {
    try {
        // Get the hidden field elements
        var hiddenField = document.getElementById('<%= hdnEditRecordID.ClientID %>');
        var recordIdField = document.getElementById('<%= HiddenFieldRecordID.ClientID %>');
        var popup = document.getElementById('<%= pnlEditPopup.ClientID %>');
        var loadButton = document.getElementById('<%= btnLoadEditData.ClientID %>');
        var overlay = document.querySelector('.edit-popup-overlay');

        // Check if all required elements exist
        if (!hiddenField) {
            console.error('Hidden field not found');
            return false;
        }
        if (!recordIdField) {
            console.error('Record ID field not found');
            return false;
        }
        if (!popup) {
            console.error('Popup element not found');
            return false;
        }
        if (!loadButton) {
            console.error('Load button not found');
            return false;
        }
        if (!overlay) {
            console.error('Overlay element not found');
            return false;
        }

        // Set the record IDs in both hidden fields
        hiddenField.value = recordId;
        recordIdField.value = recordId;
        
        // Show the overlay and popup
        overlay.style.display = 'block';
        overlay.classList.add('show');
        popup.style.display = 'block';
        popup.classList.add('show');
        
        // Trigger the server-side load of edit data
        loadButton.click();
        
        return false;
    } catch (error) {
        console.error('Error in handleEditClick:', error);
        return false;
    }
}

function closeEditPopup() {
    try {
        // Get the hidden field elements
        var hiddenField = document.getElementById('<%= hdnEditRecordID.ClientID %>');
        var recordIdField = document.getElementById('<%= HiddenFieldRecordID.ClientID %>');
        var popup = document.getElementById('<%= pnlEditPopup.ClientID %>');
        var overlay = document.querySelector('.edit-popup-overlay');

        // Check if elements exist
        if (!hiddenField || !recordIdField || !popup || !overlay) {
            console.error('Required elements not found');
            return;
        }

        // Clear the hidden fields
        hiddenField.value = '';
        recordIdField.value = '';
        
        // Hide the popup and overlay
        popup.classList.remove('show');
        overlay.classList.remove('show');
        setTimeout(function() {
            popup.style.display = 'none';
            overlay.style.display = 'none';
        }, 300);
    } catch (error) {
        console.error('Error in closeEditPopup:', error);
    }
}

function showEditPopup(rowID) {
    document.getElementById('<%= HiddenFieldRecordID.ClientID %>').value = rowID;
    document.getElementById('<%= pnlEditPopup.ClientID %>').style.display = 'block';
}

// Delete confirmation function
function confirmDelete(linkButton) {
    var password = prompt("الرجاء إدخال كلمة المرور لتأكيد الحذف:");
    if (password === null) {
        return false;
    }

    var isValid = false;
    $.ajax({
        type: "POST",
        url: "inventory.aspx/CheckPasswordAndPermission",
        data: JSON.stringify({ userPassword: password }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
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

// Add event listener for the close button
document.addEventListener('DOMContentLoaded', function() {
    var closeBtn = document.getElementById('<%= btnCloseEditPopup.ClientID %>');
    if (closeBtn) {
        closeBtn.onclick = function() {
            closeEditPopup();
            return false;
        };
    }
});

// Initialize when the DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    try {
        // Initialize calendar using jQuery
        if (typeof jQuery !== 'undefined') {
            var $j = jQuery.noConflict();
            if (typeof $j !== 'undefined') {
                var dateInput = document.getElementById('<%=TxtDate.ClientID %>');
                if (dateInput) {
                    $j(dateInput).dynDateTime({
                        Date: 'now',
                        showsTime: true,
                        timeFormat: "12",
                        ifFormat: "%d/%m/%Y",
                        daFormat: "%e/%m/%Y",
                        align: "BR",
                        electric: true,
                        singleClick: true,
                        displayArea: ".siblings('.dtcDisplayArea')",
                        button: ".next()",
                        allowInputToggle: true
                    });
                }
            }
        }

        // Initialize authority dropdown
        var dropAuthority = document.getElementById("Drop_Authority");
        var txtAuthority = document.getElementById("<%= Txt_Authority.ClientID %>");
        if (dropAuthority && txtAuthority) {
            dropAuthority.addEventListener("change", function() {
                var valid = false;
                var dataList = document.getElementById("authorityList");
                if (dataList && dataList.options) {
                    for (var i = 0; i < dataList.options.length; i++) {
                        if (dropAuthority.value === dataList.options[i].value) {
                            valid = true;
                            break;
                        }
                    }
                    if (!valid) {
                        alert("⚠ الرجاء اختيار قيمة صحيحة من القائمة فقط!");
                        dropAuthority.value = "";
                        txtAuthority.value = "";
                    } else {
                        txtAuthority.value = dropAuthority.value;
                    }
                }
            });
        }

        // Initialize incoming dropdown
        var dropIncoming = document.getElementById("Drop_Incoming");
        var txtIncomingFrom = document.getElementById("<%= TXT_incoming_From.ClientID%>");
        if (dropIncoming && txtIncomingFrom) {
            dropIncoming.addEventListener("change", function() {
                var selectedValue = this.value;
                txtIncomingFrom.value = selectedValue;
            });
        }

        // Initialize time dropdown
        var dropTime = document.getElementById("<%= Drop_Time.ClientID %>");
        var txtRequiredTime = document.getElementById("<%= Txt_Required_Time.ClientID %>");
        if (dropTime && txtRequiredTime) {
            dropTime.addEventListener("change", function() {
                if (this.value === "بدون وقت") {
                    txtRequiredTime.value = "";
                    txtRequiredTime.style.display = "none";
                } else {
                    txtRequiredTime.value = this.value;
                    txtRequiredTime.style.display = "inline-block";
                }
            });
        }

        // Add event listener for file upload changes
        var fileUpload = document.getElementById('<%= FileUploadMulti.ClientID %>');
        if (fileUpload) {
            fileUpload.addEventListener('change', function() {
                // You can add any file validation logic here
                console.log('Files selected:', this.files.length);
            });
        }
    } catch (error) {
        console.error('Error in DOMContentLoaded:', error);
    }
}); 