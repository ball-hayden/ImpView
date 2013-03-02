display = window.display

getVisibility = (target) ->
  value = (if $("#" + target).is(":visible") then "visible" else "hidden")
  return value

display.sendVisibility = (target) ->
  display.sendMessage({ type: "query-visible", target: target, value: getVisibility(target), callback: true })