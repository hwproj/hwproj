$ ->
  modal_holder_selector = '#modal-holder'
  modal_selector = '.modal'

  # Show modal on click
  $(document).on 'click', 'a[data-modal]', ->
    location = $(this).attr('href')
    $('.modal-backdrop').remove() if ($(this).parents(modal_holder_selector).length != 0)
    $.get location, (data) ->
      $(modal_holder_selector).html(data)
      $(modal_holder_selector).find(modal_selector).modal()
    false

  # Correct processing
  $(document).on 'ajax:success',
    'form[data-modal]', (event, data, status, xhr)->
      url = xhr.getResponseHeader('Location')
      if url
        # Redirect to url
        window.location = url
      else
        # Remove old modal backdrop
        $('.modal-backdrop').remove()

        # Replace old modal with new one
        $(modal_holder_selector).html(data).
        find(modal_selector).modal()

      false
