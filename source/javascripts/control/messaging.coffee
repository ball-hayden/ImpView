control = window.control

messageHandlers  = control.messageHandlers
callbackHandlers = control.callbackHandlers

control.onReadys.push ->
  window.addEventListener "message", ((event) ->
    handleMessage(event.data, event.source);
  ), false

control.sendMessage = (messageData) ->
  control.display.postMessage JSON.stringify(messageData), "*"

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

messageHandlers.push (message) ->
  switch message.type
    when "hello"
      $('#loader').fadeOut(1000, ->
        $('#loader').remove
        $('#controls').fadeIn()
      )
      control.sendMessage({ type: "hello", callback: true })