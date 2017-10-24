#= require jquery
#= require bootstrap/tooltip

$(document).on 'ready page:load ajaxComplete', ->
  $('[data-toggle=tooltip]').tooltip()
