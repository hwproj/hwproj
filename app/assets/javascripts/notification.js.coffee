$(document).on 'click', '[data-behavior~=update-is_read]', (_this) ->  
  is_read = this.classList.contains('unread')
  $.ajax
    type: 'PUT'
    url: '/notifications/' + @id
    data:
      is_read: is_read
      id: @id
  notification = document.getElementById('notification' + @id)  
  unread_link = document.getElementById("unread")

  if is_read
    this.classList.add('read')
    this.classList.remove('unread')
    this.text = "Непрочитанные"
    unread_count -= 1
  else
    this.classList.add('unread')
    this.classList.remove('read')
    this.text = "читать"
    unread_count += 1
  unread_link.text = "Непрочитанные#{if (unread_count > 0) then " (#{unread_count})" else ""}"
