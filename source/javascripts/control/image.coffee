control = window.control

onReadys = control.onReadys
callbackHandlers = control.callbackHandlers
clickHandlers = control.clickHandlers
stateHandlers = control.stateHandlers

sendMessage = control.sendMessage

callbackHandlers.push (message) ->
  # Image specific callback handlers
  return unless message.target == "image"

  if message.type == "control"
    switch message.action
      when "setSource"
        $('#controls-image-loader').text("Loaded")
  else if message.type == "error"
    $('#controls-image-loader').text(message.value)

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

  $('.preset-images a').click (e) ->
      img = $(e.currentTarget).find("img")[0]
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

  $('#image-file').change ->
    input = $('#image-file')[0]
    url = window.webkitURL.createObjectURL(input.files[0])

    $('#image-input').val(url)
    $('#controls-image-loader').text("Loading...")
    sendMessage({ type: "control", target:"image", action: "setSource", value: url })