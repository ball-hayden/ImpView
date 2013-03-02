control = window.control

control.callbackHandlers.push (message) ->
  switch message.type
    when "query-visible"
      $('#' + message.target + '-state').val(message.value).change()