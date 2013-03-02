display = window.display

imagePreloader = new Image();

messageHandlers = display.messageHandlers

messageHandlers.push (message) ->
  return unless message.type == "control" && message.target == "image"

  target = message.target
  target$ = $('#' + target)

  switch message.action
    when "setSource"
      imagePreloader.onload = ->
        display.sendMessage({ type: "control", target:"image", action: "setSource", callback: true })
        return
      imagePreloader.src=message.value
      target$.css
        'background-image': 'url("' + message.value + '")'