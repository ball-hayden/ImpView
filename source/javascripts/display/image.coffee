display = window.display

messageHandlers = display.messageHandlers

messageHandlers.push (message) ->
  return unless message.type == "control" && message.target == "image"

  target = message.target
  target$ = $('#' + target)

  switch message.action
    when "setSource"
      error = (status) ->
        switch status
          when 404
            message = "Image not found"
          when 500
            message = "Server-side error loading image"
          else
            message = "Unknown error loading image"

        display.sendMessage({ type: "error", target: "image", value: message, callback: true })

      xhr = new XMLHttpRequest()
      xhr.open "GET", message.value, true
      xhr.responseType = "blob"
      xhr.onload = (e) ->
        if e.target.status == 200
          url = window.webkitURL.createObjectURL(@response)
          target$.css
            'background-image': 'url("' + url + '")'

          display.sendMessage({ type: "control", target:"image", action: "setSource", callback: true })
        else
          error e.target.status
        return
      xhr.onerror = (e) ->
        error e.target.status

      xhr.send()