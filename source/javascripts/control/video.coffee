control = window.control

callbackHandlers = control.callbackHandlers
clickHandlers = control.clickHandlers
stateHandlers = control.stateHandlers
onReadys = control.onReadys

sendMessage = control.sendMessage

callbackHandlers.push (message) ->
  return unless message.target == "video"

  if message.type == "control"
    switch message.action
      when "setSource"
        $('#controls-video-loader').text("Loaded")
      when "playing", "paused"
        $('#' + message.target + '-play-state').val(message.action).change()
  else if message.type == "error"
    $('#controls-video-loader').text(message.value)

clickHandlers.push ->
  $('#controls-show-hide-video').click ->
    if $('#video-state').val() == "hidden"
      sendMessage({ type: "control", target: "video", action: "show" })
    else
      sendMessage({ type: "control", target: "video", action: "hide" })

  $('#controls-fade-video').click ->
    if $('#video-state').val() == "hidden"
      sendMessage({ type: "control", target: "video", action: "fadeIn" })
    else
      sendMessage({ type: "control", target: "video", action: "fadeOut" })

  $('#controls-play-video').click ->
    if $('#video-play-state').val() == "playing"
      sendMessage({ type: "control", target: "video", action: "pause" })
    else
      sendMessage({ type: "control", target: "video", action: "play" })

  $('#controls-restart-video').click ->
    sendMessage({ type: "control", target: "video", action: "restart" })

  $('#controls-show-play-video').click ->
    sendMessage({ type: "control", target: "video", action: "show" })
    sendMessage({ type: "control", target: "video", action: "play" })

  $('#controls-hide-restart-video').click ->
    sendMessage({ type: "control", target: "video", action: "hide" })
    sendMessage({ type: "control", target: "video", action: "pause" })
    sendMessage({ type: "control", target: "video", action: "restart" })

  $('.preset-videos a').click (e) ->
      video = $(e.currentTarget).find('video')[0]
      $('#video-input').val(video.src)
      $('#video-input').keyup()

  $('.preset-videos video').each (i, item) ->
    # It doesn't like is straight away...
    setTimeout( ->
      item.currentTime = 2
    , 1000)

setVideoButtonStates = ->
  show_hide = $('#controls-show-hide-video')
  fade = $('#controls-fade-video')
  if $('#video-state').val() == "hidden"
    show_hide.text("Show Video")
    fade.text("Fade Video In")
  else
    show_hide.text("Hide Video")
    fade.text("Fade Video Out")

  if $('#video-play-state').val() == "playing"
    $('#controls-play-video').text("Pause Video")
  else
    $('#controls-play-video').text("Play Video")

  return

stateHandlers.push ->
  $('#video-state').change setVideoButtonStates
  $('#video-play-state').change setVideoButtonStates

onReadys.push ->
  video_src = ""
  $('#video-input').keyup ->
    return if video_src == $('#video-input').val()

    video_src = $('#video-input').val()
    $('#controls-video-loader').text("Loading...")
    sendMessage({ type: "control", target:"video", action: "setSource", value: video_src })

  $('#video-file').change ->
    input = $('#video-file')[0]
    url = window.webkitURL.createObjectURL(input.files[0])

    $('#video-input').val(url)
    $('#controls-video-loader').text("Loading...")
    sendMessage({ type: "control", target:"video", action: "setSource", value: url })