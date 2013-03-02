control = window.control
clickHandlers = control.clickHandlers

clickHandlers.push ->
  $('#quick-hide-all').click ->
    hideAll()

  $('#quick-fade-all').click ->
    fadeOutAll()

hideAll = ->
  $('.states input').each (i, item) ->
    if $(item).val() == "visible"
      name = $(item).attr('id').replace("-state", "")
      $('#controls-show-hide-' + name).click()
  return

fadeOutAll = ->
  $('.states input').each (i, item) ->
    if $(item).val() == "visible"
      name = $(item).attr('id').replace("-state", "")
      $('#controls-fade-' + name).click()
  return