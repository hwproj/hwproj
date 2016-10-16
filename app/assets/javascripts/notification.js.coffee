$(document).on 'click', '[data-behavior~=update-is_read]', (_this) ->
  $.ajax
    type: 'PUT'
    url: '/notifications/' + @id
    data:
      is_read: @checked
      id: @id
  notification = document.getElementById('notification' + @id)
  check_box = document.getElementById(@id)
  unread_link = document.getElementById("unread")

  if @checked
    notification.classList.add('read_notification')
    check_box.title = 'Отметить как непрочитанное'
    unread_count -= 1
  else
    notification.classList.remove('read_notification')
    check_box.title = 'Отметить как прочитанное'
    unread_count += 1
  unread_link.text = "Непрочитанные#{if (unread_count > 0) then " (#{unread_count})" else ""}"
