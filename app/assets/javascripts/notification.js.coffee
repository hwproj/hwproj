$(document).on 'click', '[data-behavior~=update-is_read]', (_this) ->
  $.ajax
    type: 'PUT'
    url: '/notifications/' + @id
    data:
      is_read: @checked
      id: @id
