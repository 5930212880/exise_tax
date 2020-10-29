
$(document).on('turbolinks:load', function() {
        $('.datepicker').datepicker({
            locale: 'th',
            sideBySide: true,
            format: 'yyyymmdd',
            autoclose: true 
          });
    });
