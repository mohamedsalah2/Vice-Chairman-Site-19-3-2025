// Wait for both jQuery and Flatpickr to be loaded
function waitForDependencies(callback, maxAttempts = 10) {
    let attempts = 0;
    const checkDependencies = () => {
        if (typeof jQuery !== 'undefined' && typeof flatpickr !== 'undefined') {
            callback();
            return;
        }
        attempts++;
        if (attempts < maxAttempts) {
            setTimeout(checkDependencies, 100);
        } else {
            console.error('Failed to load required dependencies');
        }
    };
    checkDependencies();
}

// Calendar initialization
function initializeCalendar() {
    try {
        // Find all date input fields (both ASP.NET and regular inputs)
        var dateInputs = jQuery('input[type="text"].dynDateTime, input[type="text"][id*="TxtDate"]');
        if (!dateInputs.length) {
            console.log('No calendar elements found');
            return;
        }

        // Get current date and time
        var now = new Date();
        var currentDate = now.toISOString().split('T')[0];
        var currentTime = now.toTimeString().slice(0, 5);

        // Check if page is RTL
        var isRTL = document.body.getAttribute('dir') === 'rtl';

        // Configure Flatpickr options
        var defaultOptions = {
            enableTime: true,
            dateFormat: "Y-m-d H:i",
            time_24hr: true,
            defaultDate: now,
            locale: isRTL ? "ar" : "default",
            position: isRTL ? "auto" : "auto",
            allowInput: true,
            showMonths: 1,
            minuteIncrement: 5,
            onChange: function(selectedDates, dateStr, instance) {
                try {
                    // Add visual feedback
                    var input = instance.input;
                    jQuery(input).addClass('selected');
                    setTimeout(function() {
                        jQuery(input).removeClass('selected');
                    }, 500);

                    // Trigger change event for ASP.NET validation
                    jQuery(input).trigger('change');
                } catch (error) {
                    console.error('Error in onChange:', error);
                }
            },
            onClose: function(selectedDates, dateStr, instance) {
                try {
                    // Validate the date when calendar is closed
                    var input = instance.input;
                    var value = input.value;
                    if (value) {
                        var date = new Date(value);
                        if (isNaN(date)) {
                            alert('الرجاء إدخال تاريخ صحيح');
                            jQuery(input).val('');
                        }
                    }
                } catch (error) {
                    console.error('Error in onClose:', error);
                }
            }
        };

        // Initialize Flatpickr on each input
        dateInputs.each(function() {
            try {
                var input = this;
                // Skip if already initialized
                if (input._flatpickr) return;

                // Get existing value if any
                var existingValue = jQuery(input).val();
                var options = jQuery.extend({}, defaultOptions);

                // If there's an existing value, use it as default date
                if (existingValue) {
                    try {
                        var parsedDate = new Date(existingValue);
                        if (!isNaN(parsedDate)) {
                            options.defaultDate = parsedDate;
                        }
                    } catch (e) {
                        console.warn('Invalid date format in input:', existingValue);
                    }
                }

                // Initialize Flatpickr
                var fp = flatpickr(input, options);

                // Add custom styling for RTL support
                if (isRTL) {
                    var calendarContainer = jQuery(input).next('.flatpickr-calendar');
                    if (calendarContainer.length) {
                        calendarContainer.css({
                            'direction': 'rtl',
                            'text-align': 'right'
                        });
                    }
                }

                // Store the Flatpickr instance
                input._flatpickr = fp;
            } catch (error) {
                console.error('Error initializing calendar for input:', error);
            }
        });
    } catch (error) {
        console.error('Error in initializeCalendar:', error);
    }
}

// Initialize calendar when dependencies are loaded
function checkDependencies() {
    if (typeof jQuery !== 'undefined' && typeof flatpickr !== 'undefined') {
        // Initialize on document ready
        jQuery(function($) {
            initializeCalendar();
        });

        // Re-initialize after postback
        if (typeof Sys !== 'undefined' && Sys.WebForms) {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function() {
                initializeCalendar();
            });
        }
    } else {
        setTimeout(checkDependencies, 100);
    }
}

// Start checking for dependencies
checkDependencies();

// Add custom styles for calendar
jQuery(function($) {
    var style = document.createElement('style');
    style.textContent = 
        '.dynDateTime, input[id*="TxtDate"] {' +
        '    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;' +
        '    border: 1px solid #ddd;' +
        '    border-radius: 4px;' +
        '    padding: 8px;' +
        '    background-color: #fff;' +
        '    width: 100%;' +
        '    max-width: 300px;' +
        '    transition: border-color 0.3s ease;' +
        '}' +
        '.dynDateTime:focus, input[id*="TxtDate"]:focus {' +
        '    border-color: #80bdff;' +
        '    outline: 0;' +
        '    box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);' +
        '}' +
        '.dynDateTime.selected, input[id*="TxtDate"].selected {' +
        '    background-color: #e3f2fd;' +
        '}' +
        '.flatpickr-calendar {' +
        '    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;' +
        '    border-radius: 8px;' +
        '    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);' +
        '    z-index: 1000;' +
        '}' +
        '.flatpickr-day {' +
        '    border-radius: 4px;' +
        '    margin: 2px;' +
        '}' +
        '.flatpickr-day.selected {' +
        '    background-color: #007bff;' +
        '    border-color: #007bff;' +
        '}' +
        '.flatpickr-day.today {' +
        '    background-color: #e3f2fd;' +
        '    border-color: #e3f2fd;' +
        '}' +
        '.flatpickr-time {' +
        '    border-top: 1px solid #eee;' +
        '}' +
        '.flatpickr-time input {' +
        '    border: 1px solid #ddd;' +
        '    border-radius: 4px;' +
        '    padding: 4px;' +
        '    width: 50px;' +
        '}' +
        '[dir="rtl"] .flatpickr-calendar {' +
        '    direction: rtl;' +
        '}' +
        '[dir="rtl"] .flatpickr-day {' +
        '    text-align: right;' +
        '}' +
        '[dir="rtl"] .flatpickr-months .flatpickr-month {' +
        '    text-align: right;' +
        '}' +
        '[dir="rtl"] .flatpickr-current-month {' +
        '    text-align: right;' +
        '}' +
        '[dir="rtl"] .flatpickr-weekdays {' +
        '    text-align: right;' +
        '}';
    document.head.appendChild(style);
}); 