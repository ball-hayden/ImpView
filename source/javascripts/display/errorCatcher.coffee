display = window.display

window.onerror = (msg, url, line) ->
  display.sendError(msg, url, line, "Unknown")

display.sendError = (msg, url, line, trace) ->
  display.sendMessage
    type: "error"
    target: "window"
    msg: msg
    url: url
    line: line
    trace: trace
    callback: true
  return