jQuery(document).on('ready page:load',function() {
     $('#new_note, #new_message').keydown(function(event) {
     	if (event.which == 13 && event.shiftKey && !event.ctrlKey) {
     		event.preventDefault();
     		$(this).submit();
     	}
     })

     $('#new_note #note_text').on('input', function() {
     	$('#submit_button').attr('disabled', $(this).val().trim() == '');
     })
});
