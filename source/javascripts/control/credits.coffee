control = window.control

onReadys = control.onReadys
callbackHandlers = control.callbackHandlers
clickHandlers = control.clickHandlers
stateHandlers = control.stateHandlers

sendMessage = control.sendMessage

clickHandlers.push ->
  $('#controls-roll-credits').click ->
    sendMessage({ type: "control", target: "credits", action: "roll" })

  $('#controls-hide-credits').click ->
    sendMessage({ type: "control", target: "credits", action: "hide" })

onReadys.push ->
  $('#credits-editor').keyup ->
    sendMessage({ type: "control", target:"credits", action: "setValue", value: $('#credits-editor').val() })