jQuery(document).on('ready page:load page:restore',function() {
  var converter = new Showdown.converter();

  $('.markdown').each(function()
  {
    $(this).html(converter.makeHtml($(this).html()));
    $("p", this).replaceWith($("p", this).html());
  })

  var note_textarea = $("#note_text");
  var message_textarea = $("#message_text");
  var note_preview = $("#note-preview-text");
  var message_preview = $("#message-preview-text");
  console.log(note_textarea);

  $('a[href="#note-preview"]').on('show.bs.tab', function() {
  console.log(note_textarea.val());
  note_preview.html(converter.makeHtml(note_textarea.val()));
  });

  $('a[href="#message-preview"]').on('show.bs.tab', function() {
  message_preview.html(converter.makeHtml(message_textarea.val()));
  });
});
