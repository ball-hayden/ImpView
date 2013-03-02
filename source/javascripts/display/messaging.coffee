display = window.display
messageHandlers  = display.messageHandlers
callbackHandlers = display.callbackHandlers

display.onReadys.push ->
  window.addEventListener "message", ((event) ->
    handleMessage(event.data, event.source);
  ), false

display.sendMessage = (messageData) ->
  display.controller.postMessage JSON.stringify(messageData), "*"

handleMessage = (data, source) ->
  message = JSON.parse(data)

  console.log "received message: ", event.data

  if message.callback
    $.each callbackHandlers, (i, item) ->
      item(message)
      return
    return
  else
    $.each messageHandlers, (i, item) ->
      item(message)
      return
    return

callbackHandlers.push (message) ->
  switch message.type
    when "hello"
      $('#loader').fadeOut(1000, -> $('#loader').remove)

  return