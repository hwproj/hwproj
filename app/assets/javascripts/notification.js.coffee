$(document).on 'click', '[data-behavior~=update-is_read]', (_this) ->
  $.ajax
    type: 'PUT'
    url: '/notifications/' + @id
    data:
      is_read: @checked
      id: @id
  notification = document.getElementById('notification' + @id)
  if @checked
    notification.classList.add('read_notification')
  else
    notification.classList.remove('read_notification')