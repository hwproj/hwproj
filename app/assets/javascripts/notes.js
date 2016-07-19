jQuery(document).on('ready page:load',function() {
     $('#new_note #note_text').keydown(function(event) {
     	if (event.which == 13 && !event.ctrlKey && !event.shiftKey) {
     		event.preventDefault();
     		$('#new_note').submit();
     	}
     })

     $('#new_note #note_text').on('input', function() {
     	$('#submit_button').attr('disabled', $(this).val().trim() == '');
     })
});