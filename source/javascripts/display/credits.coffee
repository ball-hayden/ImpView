display = window.display

messageHandlers = display.messageHandlers

messageHandlers.push (message) ->
  return unless message.type == "control" && message.target == "credits"

  target = message.target
  target$ = $('#' + target)

  switch message.action
    when "setValue"
      markdown = message.value
      # For sanity:
      markdown = markdown.replace(/\n(\w)/g, "\n\n$1")
      converter = new Markdown.Converter()
      html = converter.makeHtml(markdown)
      target$.html(html)
    when "roll"
      windowHeight = $("body").outerHeight()
      height = target$.outerHeight()

      time = if (height < windowHeight) then 20 else 20 * ( height / windowHeight )

      target$.show()

      target$.css
        top: windowHeight

      target$.animate
        top: -1 * height
      , time * 1000
      , "linear"
      , ->
        target$.hide()
