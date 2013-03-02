control = window.control

onReadys = control.onReadys
callbackHandlers = control.callbackHandlers
clickHandlers = control.clickHandlers
stateHandlers = control.stateHandlers

sendMessage = control.sendMessage

callbackHandlers.push (message) ->
  # Image specific callback handlers
  return unless message.target == "image"

  switch message.action
    when "setSource"
      $('#controls-image-loader').text("Loaded")

clickHandlers.push ->
  $('#controls-show-hide-image').click ->
    if $('#image-state').val() == "hidden"
      sendMessage({ type: "control", target: "image", action: "show" })
    else
      sendMessage({ type: "control", target: "image", action: "hide" })

  $('#controls-fade-image').click ->
    if $('#image-state').val() == "hidden"
      sendMessage({ type: "control", target: "image", action: "fadeIn" })
    else
      sendMessage({ type: "control", target: "image", action: "fadeOut" })

  $('.preset-images img').click (e) ->
      img = e.target
      $('#image-input').val(img.src)
      $('#image-input').keyup()

stateHandlers.push ->
  $('#image-state').change ->
    show_hide = $('#controls-show-hide-image')
    fade = $('#controls-fade-image')
    if $('#image-state').val() == "hidden"
      show_hide.text("Show Image")
      fade.text("Fade Image In")
    else
      show_hide.text("Hide Image")
      fade.text("Fade Image Out")

onReadys.push ->
  img_src = ""
  $('#image-input').keyup ->
    return if img_src == $('#image-input').val()

    img_src = $('#image-input').val()
    $('#controls-image-loader').text("Loading...")
    sendMessage({ type: "control", target:"image", action: "setSource", value: img_src })