control = window.control

messageHandlers  = control.messageHandlers
callbackHandlers = control.callbackHandlers

control.onReadys.push ->
  if control.isChromeApp
    chrome.runtime.onMessage.addListener (request) ->
      handleMessage(request)
      return
  else
    window.addEventListener "message", (event) ->
      handleMessage(event.data, event.source);
    , false

control.sendMessage = (messageData) ->
  msg = JSON.stringify(messageData)

  if control.isChromeApp
    chrome.runtime.sendMessage null, msg
  else
    control.display.postMessage msg, "*"

handleMessage = (data) ->
  try
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

  catch e
    control.showError e.msg, e.url, e.line, e.stack

messageHandlers.push (message) ->
  switch message.type
    when "hello"
      $('#loader').fadeOut(1000, ->
        $('#loader').remove
        $('#controls').fadeIn()
      )
      control.sendMessage({ type: "hello", callback: true })