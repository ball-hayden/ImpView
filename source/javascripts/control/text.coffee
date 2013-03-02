control = window.control

clickHandlers = control.clickHandlers
stateHandlers = control.stateHandlers
onReadys = control.onReadys

sendMessage = control.sendMessage

clickHandlers.push ->
  $('#controls-show-hide-text').click ->
    if $('#text-state').val() == "hidden"
      sendMessage({ type: "control", target: "text", action: "show" })
    else
      sendMessage({ type: "control", target: "text", action: "hide" })

  $('#controls-fade-text').click ->
    if $('#text-state').val() == "hidden"
      sendMessage({ type: "control", target: "text", action: "fadeIn" })
    else
      sendMessage({ type: "control", target: "text", action: "fadeOut" })

  $('.preset-text a').click (e) ->
    $('#text-input').val($(e.target).text())
    $('#text-input').keyup()

stateHandlers.push ->
  $('#text-state').change ->
    show_hide = $('#controls-show-hide-text')
    fade = $('#controls-fade-text')
    if $('#text-state').val() == "hidden"
      show_hide.text("Show Text")
      fade.text("Fade Text In")
    else
      show_hide.text("Hide Text")
      fade.text("Fade Text Out")

onReadys.push ->
  $('#text-input').keyup ->
    sendMessage({ type: "control", target:"text", action: "setValue", value: $('#text-input').val() })

  $('#text-color').change ->
    sendMessage({ type: "control", target:"text", action: "setColor", value: $('#text-color').val() })