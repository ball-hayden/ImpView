display = window.display
messageHandlers = display.messageHandlers

messageHandlers.push (message) ->
  return unless message.type == "control" && message.target == "video"

  target = message.target
  target$ = $('#' + target)

  switch message.action
    when "setSource"
      xhr = new XMLHttpRequest()
      xhr.open "GET", message.value, true
      xhr.responseType = "blob"
      xhr.onload = (e) ->
        url = window.webkitURL.createObjectURL(@response)
        target$.attr('src', url)

        display.sendMessage({ type: "control", target:"video", action: "setSource", callback: true })
        return

      xhr.send()
    when "play"
      target$.off 'ended'
      target$.on 'ended', ->
        display.sendMessage({ type: "control", target: target, action: "paused", callback: true })

      target$[0].play()

      display.sendMessage({ type: "control", target: target, action: "playing", callback: true })
    when "pause"
      target$[0].pause()
      display.sendMessage({ type: "control", target: target, action: "paused", callback: true })
    when "restart"
      target$[0].currentTime = 0

display.onReadys.push ->
  video = $('#video')[0]
  video.onerror = ->
    e = video.error

    switch e.code
      when e.MEDIA_ERR_DECODE
        nice_error = "Video couldn't be decoded. Codec may not be supported"
      when e.MEDIA_ERR_SRC_NOT_SUPPORTED
        nice_error = "This video format isn't supported"
      else
        nice_error = "An unknown error occurred"

    display.sendMessage({ type: "error", target: "video", value: nice_error, callback: true })