display = window.display
messageHandlers = display.messageHandlers

messageHandlers.push (message) ->
  return unless message.type == "control"

  target = message.target
  target$ = $('#' + target)

  switch message.action
    when "hide"
      target$.hide();
      display.sendVisibility(message.target)
    when "show"
      target$.show();
      display.sendVisibility(message.target)
    when "setValue"
      target$.text(message.value)
    when "setColor"
      target$.css({ color: message.value })
    when "setSource"
      target$.attr('src', message.value) unless target == "image"
    when "fadeIn"
      target$.fadeIn(1000, -> display.sendVisibility(message.target));
    when "fadeOut"
      target$.fadeOut(1000, -> display.sendVisibility(message.target));
    when "animate"
      display.animate(message, target, target$)
    when "toggle-class"
      target$.toggleClass(message.value)