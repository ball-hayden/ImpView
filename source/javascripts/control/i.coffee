control = window.control

clickHandlers = control.clickHandlers
stateHandlers = control.stateHandlers

sendMessage = control.sendMessage

clickHandlers.push ->
  $('#controls-show-hide-i').click ->
    if $('#i-state').val() == "hidden"
      sendMessage({ type: "control", target: "i", action: "show" })
    else
      sendMessage({ type: "control", target: "i", action: "hide" })
    return

  $('#controls-fade-i').click ->
    if $('#i-state').val() == "hidden"
      sendMessage({ type: "control", target: "i", action: "fadeIn" })
    else
      sendMessage({ type: "control", target: "i", action: "fadeOut" })
    return

stateHandlers.push ->
  $('#i-state').change ->
    show_hide = $('#controls-show-hide-i')
    fade = $('#controls-fade-i')
    if $('#i-state').val() == "hidden"
      show_hide.text("Show i")
      fade.text("Fade i In")
    else
      show_hide.text("Hide i")
      fade.text("Fade i Out")