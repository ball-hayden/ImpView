control = window.control

clickHandlers = control.clickHandlers
onReadys      = control.onReadys
stateHandlers = control.stateHandlers

sendMessage = control.sendMessage

clickHandlers.push ->
  $('#controls-show-hide-alphabet').click ->
    if $('#alphabet-state').val() == "hidden"
      sendMessage({ type: "control", target: "alphabet", action: "show" })
    else
      sendMessage({ type: "control", target: "alphabet", action: "hide" })
  $('#controls-next-alphabet').click ->
    sendMessage({ type: "control", target: "alphabet", action: "next" })

stateHandlers.push ->
  $('#alphabet-state').change ->
    show_hide = $('#controls-show-hide-alphabet')
    if $('#alphabet-state').val() == "hidden"
      show_hide.text("Show Alphabet")
    else
      show_hide.text("Hide Alphabet")

onReadys.push ->
  $('#set-start-alphabet').keyup ->
    start = $('#set-start-alphabet').val()

    return if start == ""

    sendMessage({ type: "control", target: "alphabet", action: "setStart", value: start })