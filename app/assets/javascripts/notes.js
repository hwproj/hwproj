jQuery(document).on('ready page:load',function() {
     $('#new_note #note_text').keydown(function(event) {
     	if (event.which == 13 && !event.ctrlKey && !event.shiftKey) {
     		event.preventDefault();
     		$('#new_note').submit();
     	}
     })
});