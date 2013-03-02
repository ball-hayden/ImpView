display = window.display
messageHandlers = display.messageHandlers

messageHandlers.push (message) ->
  return unless message.type == "control" && message.target == "video"

  target = message.target
  target$ = $('#' + target)

  switch message.action
    when "play"
      target$[0].play()
      sendMessage({ type: "control", target: target, action: "playing", callback: true })
    when "pause"
      target$[0].pause()
      sendMessage({ type: "control", target: target, action: "paused", callback: true })
    when "restart"
      target$[0].currentTime = 0