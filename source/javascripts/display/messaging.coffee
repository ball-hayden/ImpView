display = window.display
messageHandlers  = display.messageHandlers
callbackHandlers = display.callbackHandlers

display.onReadys.push ->
  if display.isChromeApp
    chrome.runtime.onMessage.addListener (request) ->
      handleMessage(request)
      return
  else
    window.addEventListener "message", (event) ->
      handleMessage(event.data, event.source);
    , false

display.sendMessage = (messageData) ->
  msg = JSON.stringify(messageData)

  if display.isChromeApp
    chrome.runtime.sendMessage null, msg
  else
    display.controller.postMessage msg, "*"

handleMessage = (data, source) ->
  message = JSON.parse(data)

  console.log "received message: ", data

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