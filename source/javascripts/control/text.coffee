control = window.control

clickHandlers = control.clickHandlers
stateHandlers = control.stateHandlers
onReadys = control.onReadys

sendMessage = control.sendMessage

games = []
addTextTypeahead = ->
  text$ = $('#text-input')
  text$.typeahead
    source: (query, process) ->
      # Copy the games array
      list = games.slice(0)

      # Add the current query to the data (but titleize it first).
      query = query.replace /(\w|')*/g, (txt) ->
        txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
      list.unshift(query)

      process(list)

      return

    updater: (item) ->
      sendMessage({ type: "control", target:"text", action: "setValue", value: item })

      return item

clickHandlers.push ->
  $('#controls-show-hide-text').click ->
    if $('#text-state').val() == "hidden"
      sendMessage({ type: "control", target: "text", action: "show" })
    else
      sendMessage({ type: "control", target: "text", action: "hide" })

  $('#controls-fade-text').click ->
    if $('#text-state').val() == "hidden"
      sendMessage({ type: "control", target: "text", action: "fadeIn" })
    else
      sendMessage({ type: "control", target: "text", action: "fadeOut" })

stateHandlers.push ->
  $('#text-state').change ->
    show_hide = $('#controls-show-hide-text')
    fade = $('#controls-fade-text')
    if $('#text-state').val() == "hidden"
      show_hide.text("Show Text")
      fade.text("Fade Text In")
    else
      show_hide.text("Hide Text")
      fade.text("Fade Text Out")

onReadys.push ->
  $('#text-input').keyup ->
    sendMessage({ type: "control", target:"text", action: "setValue", value: $('#text-input').val() })

  $('#text-color').change ->
    sendMessage({ type: "control", target:"text", action: "setColor", value: $('#text-color').val() })

  # Fetch the games list:
  $.ajax
    url: 'content/games.json',
    dataType: 'json',
    success: (data) ->
      games = data

  addTextTypeahead()

  return