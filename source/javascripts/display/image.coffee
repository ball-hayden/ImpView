display = window.display

messageHandlers = display.messageHandlers

messageHandlers.push (message) ->
  return unless message.type == "control" && message.target == "image"

  target = message.target
  target$ = $('#' + target)

  switch message.action
    when "setSource"
      xhr = new XMLHttpRequest()
      xhr.open "GET", message.value, true
      xhr.responseType = "blob"
      xhr.onload = (e) ->
        url = window.webkitURL.createObjectURL(@response)
        target$.css
          'background-image': 'url("' + url + '")'

        display.sendMessage({ type: "control", target:"image", action: "setSource", callback: true })
        return

      xhr.send()