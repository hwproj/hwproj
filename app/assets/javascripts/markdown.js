jQuery(document).on('ready page:load page:restore',function() {
  var converter = new Showdown.converter();
  converter.setFlavor('github');

  function submitForm(comment) {
      var form_clone = $("#new_" + comment).clone();

      form_clone.find("textarea").val( function() {
        return converter.makeHtml($(this).val())
      });

      $.ajax({
      type : 'POST',
      url : '/' + comment + 's',
      data : form_clone.find(":input").serialize()
      })

      return false;
    }

  $('#note-form').bind('submit', function()
  {
    return submitForm("note");
  });

  $('#message-form').bind('submit', function()
  {
    return submitForm("message");
  });

  var note_textarea = $("#note_text");
  var message_textarea = $("#message_text");
  var note_preview = $("#note-preview-text");
  var message_preview = $("#message-preview-text");

  $('a[href="#note-preview"]').on('show.bs.tab', function() {
  note_preview.html(converter.makeHtml(note_textarea.val()));
  });

  $('a[href="#message-preview"]').on('show.bs.tab', function() {
  message_preview.html(converter.makeHtml(message_textarea.val()));
  });
});
