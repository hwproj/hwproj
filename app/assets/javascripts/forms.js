jQuery(document).on('ready page:load page:restore', function() {
     var timeoutId;
     $('.glyphicon-wrench').popover({
         container: 'body',
         placement: 'right',
         html: true,
         trigger: 'manual',
         content: function() {
           return $('#popover_content_wrapper').html();
     }
     }).hover(function () {
         var glyphicon = this;
         if (!timeoutId) {
             timeoutId = window.setTimeout(function () {
                 timeoutId = null;
                 $(glyphicon).popover("show");
             }, 1000);
         }
     }, function () {
         if (timeoutId) {
             window.clearTimeout(timeoutId);
             timeoutId = null;
         }
         else {
             var glyphicon = this;
             if (!$(".popover:hover").length) {
                 $(glyphicon).popover("hide");
             }
         }
     });

     $("body").on('mouseleave', '.popover', function () {
         $('.glyphicon-wrench').popover("hide");
     });

     $('#new_note, #new_message').keydown(function(event) {
       if (submission_form_type == "Ctrl+Enter" && event.which == 13 && event.ctrlKey ||
           submission_form_type == "Shift+Enter" && event.which == 13 && event.shiftKey ||
           submission_form_type == "Enter" && event.which == 13 && !event.ctrlKey && !event.shiftKey)
           {
             event.preventDefault();
             $(this).submit();
           }
     });

     $('#new_note #note_text').on('input', function() {
     	$('#submit_button').attr('disabled', $(this).val().trim() == '');
    });

    function replaceHints(str1, str2, str3)
    {
      $(".help-block").each(function() {
        var $this = $(this);
        $this.text($this.text().replace(submission_form_type, str1).replace(str2, str3))
      });
      submission_form_type = str1;
    }

    $("body").on('change', "[name=submission_form_type]", function(){
      if($('[id*=ctrl_enter]').is(':checked'))
      {
        replaceHints("Ctrl+Enter", "Shift+Enter –", "Enter –");
      }

      if($('[id*=shift_enter]').is(':checked'))
      {
        replaceHints("Shift+Enter", "Shift+Enter –", "Enter –");
      }

      if($("[id=submission_form_type_enter]").is(':checked'))
      {
        replaceHints("Enter", "Enter –", "Shift+Enter –");
      }

//This is the magic that`s needed for correct work of popover
      $(".popover-content [name=submission_form_type]").each(function() {
        this.removeAttribute("checked");
      });

      this.setAttribute("checked","checked");

      $("#popover_content_wrapper").html($(".popover-content").html());
      $(".popover-content").html($("#popover_content_wrapper").html());
    });
});
