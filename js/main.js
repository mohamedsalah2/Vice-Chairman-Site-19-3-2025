// Document Ready
document.addEventListener('DOMContentLoaded', function() {
    try {
        // Handle search textbox placeholder only if elements exist
        const searchTextBoxes = document.querySelectorAll('[data-placeholder]');
        if (searchTextBoxes.length > 0) {
            searchTextBoxes.forEach(textbox => {
                const placeholder = textbox.getAttribute('data-placeholder');
                textbox.value = placeholder;
                
                textbox.addEventListener('focus', function() {
                    if (this.value === placeholder) {
                        this.value = '';
                    }
                });
                
                textbox.addEventListener('blur', function() {
                    if (this.value.trim() === '') {
                        this.value = placeholder;
                    }
                });
            });
        }

        // Handle authority validation only if elements exist
        const dropAuthority = document.getElementById('Drop_Authority');
        const txtAuthority = document.getElementById('Txt_Authority');
        const authorityList = document.getElementById('authorityList');
        
        if (dropAuthority && txtAuthority && authorityList) {
            dropAuthority.addEventListener('change', function() {
                const valid = Array.from(authorityList.options)
                    .some(option => option.value === this.value);
                
                if (!valid) {
                    alert('⚠ الرجاء اختيار قيمة صحيحة من القائمة فقط!');
                    this.value = '';
                    txtAuthority.value = '';
                } else {
                    txtAuthority.value = this.value;
                }
            });
        }

        // Handle incoming from validation only if elements exist
        const dropIncoming = document.getElementById('Drop_Incoming');
        const txtIncoming = document.getElementById('TXT_incoming_From');
        
        if (dropIncoming && txtIncoming) {
            dropIncoming.addEventListener('change', function() {
                txtIncoming.value = this.value;
            });
        }
        
        // Initialize Bootstrap components only if Bootstrap is available
        if (typeof bootstrap !== 'undefined') {
            // Initialize Bootstrap tooltips
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            if (tooltipTriggerList.length > 0) {
                tooltipTriggerList.forEach(function(tooltipTriggerEl) {
                    new bootstrap.Tooltip(tooltipTriggerEl, {
                        placement: 'top',
                        trigger: 'hover'
                    });
                });
            }
            
            // Initialize Bootstrap popovers
            const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
            if (popoverTriggerList.length > 0) {
                popoverTriggerList.forEach(function(popoverTriggerEl) {
                    new bootstrap.Popover(popoverTriggerEl, {
                        placement: 'top',
                        trigger: 'click'
                    });
                });
            }
        }
        
        // Handle ASP.NET postbacks only if WebForm_DoPostBackWithOptions exists
        if (typeof WebForm_DoPostBackWithOptions === 'function') {
            const oldDoPostBack = WebForm_DoPostBackWithOptions;
            WebForm_DoPostBackWithOptions = function(options) {
                let validation = true;
                if (options.validation) {
                    if (typeof options.validationGroup === 'undefined') {
                        validation = Page_ClientValidate();
                    } else {
                        validation = Page_ClientValidate(options.validationGroup);
                    }
                }
                if (validation) {
                    return oldDoPostBack(options);
                }
                return false;
            };
        }
        
        // Apply Bootstrap classes to ASP.NET controls only if elements exist
        const textInputs = document.querySelectorAll("input[type='text'], input[type='password'], textarea");
        if (textInputs.length > 0) {
            textInputs.forEach(function(el) {
                el.classList.add("form-control");
            });
        }

        const buttons = document.querySelectorAll("input[type='submit'], input[type='button'], button, .aspNet-Button");
        if (buttons.length > 0) {
            buttons.forEach(function(el) {
                el.classList.add("btn", "btn-primary");
            });
        }

        const selects = document.querySelectorAll("select");
        if (selects.length > 0) {
            selects.forEach(function(el) {
                el.classList.add("form-select");
            });
        }

        const validators = document.querySelectorAll(".aspNet-Validator");
        if (validators.length > 0) {
            validators.forEach(function(el) {
                el.classList.add("text-danger");
            });
        }

        const tables = document.querySelectorAll("table");
        if (tables.length > 0) {
            tables.forEach(function(el) {
                el.classList.add("table", "table-bordered", "table-striped");
            });
        }

        // Add RTL support for Bootstrap components only if dir attribute exists
        if (document.body.getAttribute('dir') === 'rtl') {
            const dropdowns = document.querySelectorAll('.dropdown-menu');
            if (dropdowns.length > 0) {
                dropdowns.forEach(function(el) {
                    el.classList.add('text-end');
                });
            }
            
            const formControls = document.querySelectorAll('.form-control');
            if (formControls.length > 0) {
                formControls.forEach(function(el) {
                    el.classList.add('text-end');
                });
            }
        }
        
        // Handle form submissions only if forms exist
        const forms = document.querySelectorAll('form');
        if (forms.length > 0) {
            forms.forEach(form => {
                form.addEventListener('submit', function() {
                    const submitButton = this.querySelector('button[type="submit"]');
                    if (submitButton) {
                        submitButton.disabled = true;
                        submitButton.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> جاري الحفظ...';
                    }
                });
            });
        }
        
        // Handle file uploads only if file inputs exist
        const fileInputs = document.querySelectorAll('input[type="file"]');
        if (fileInputs.length > 0) {
            fileInputs.forEach(input => {
                input.addEventListener('change', function() {
                    const fileName = this.value.split('\\').pop();
                    const label = this.nextElementSibling;
                    if (label && label.classList.contains('custom-file-label')) {
                        label.textContent = fileName;
                    }
                });
            });
        }
        
        // Handle popup functionality only if overlay exists
        const overlay = document.querySelector('.popup-overlay');
        if (overlay) {
            overlay.addEventListener('click', function() {
                document.querySelectorAll('.popup-base').forEach(popup => popup.classList.remove('popup-active'));
                this.classList.remove('overlay-active');
            });
        }
        
        // Handle table sorting only if sortable headers exist
        const sortableHeaders = document.querySelectorAll('.sortable');
        if (sortableHeaders.length > 0) {
            sortableHeaders.forEach(header => {
                header.addEventListener('click', function() {
                    const table = this.closest('table');
                    const rows = Array.from(table.querySelectorAll('tr:not(:first-child)')).sort(comparator(this.cellIndex));
                    this.asc = !this.asc;
                    if (!this.asc) {
                        rows.reverse();
                    }
                    rows.forEach(row => table.appendChild(row));
                });
            });
        }
        
        // Handle responsive tables only if responsive tables exist
        const responsiveTables = document.querySelectorAll('.table-responsive');
        if (responsiveTables.length > 0) {
            function handleResponsiveTables() {
                responsiveTables.forEach(table => {
                    if (window.innerWidth < 768) {
                        table.classList.add('table-responsive');
                    } else {
                        table.classList.remove('table-responsive');
                    }
                });
            }
            
            window.addEventListener('resize', handleResponsiveTables);
            handleResponsiveTables();
        }

        // Add comparator function for table sorting
        function comparator(index) {
            return function(a, b) {
                const valA = getCellValue(a, index);
                const valB = getCellValue(b, index);
                return !isNaN(valA) && !isNaN(valB) ? valA - valB : valA.localeCompare(valB);
            };
        }

        function getCellValue(row, index) {
            return row.cells[index].textContent;
        }
    } catch (error) {
        console.error('Error initializing components:', error);
    }
});

// Session Display Function
function showSessionValues() {
    const userID = '<%= Session("UsrID") %>';
    const userName = '<%= Session("UsrName") %>';
    const permission = '<%= Session("PRMTION") %>';
    const workArea = '<%= Session("Work_Area") %>';
    const ID = '<%= Session("ID") %>';

    // Create session display modal using vanilla JavaScript
    const modal = document.createElement('div');
    modal.className = 'modal fade';
    modal.setAttribute('tabindex', '-1');
    modal.setAttribute('role', 'dialog');

    const modalContent = `
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">معلومات الجلسة</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <pre>معرف المستخدم: ${userID}
اسم المستخدم: ${userName}
الصلاحيات: ${permission}
منطقة العمل: ${workArea}
المعرف: ${ID}</pre>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">إغلاق</button>
                </div>
            </div>
        </div>
    `;

    modal.innerHTML = modalContent;
    document.body.appendChild(modal);
    const modalInstance = new bootstrap.Modal(modal);
    modalInstance.show();

    modal.addEventListener('hidden.bs.modal', function () {
        document.body.removeChild(modal);
    });
}

// Prevent automatic scrolling to top
if (typeof Sys !== 'undefined' && Sys.WebForms) {
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(function(sender, args) {
        // Store the current scroll position
        window._scrollPosition = window.pageYOffset || document.documentElement.scrollTop;
    });

    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function(sender, args) {
        // Restore the scroll position
        if (window._scrollPosition) {
            window.scrollTo(0, window._scrollPosition);
            window._scrollPosition = null;
        }
    });
}