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
      windowWidth  = $("body").outerWidth()

      height = target$.outerHeight()
      triggerHeight = windowHeight / 4

      time = if (height < windowHeight) then 20 else 20 * ( height / windowHeight )

      toAnimateIn$ = target$.children()
      # Don't use hide as we need the spacing...
      toAnimateIn$.css
        opacity: 0

      target$.show()

      target$.css
        top: windowHeight - (triggerHeight - 10)

      target$.animate
        top: -1 * height
      ,
        duration: time * 1000
        easing:   "linear"
        complete: ->
          target$.hide()
        progress: ->
          toAnimateIn$.each (i, item) ->
            item$ = $(item)
            if item$.offset().top < windowHeight - triggerHeight
              toAnimateIn$ = toAnimateIn$.not(item$)
              animateIn(item$, windowHeight, windowWidth)

animateIn = (item$, windowHeight, windowWidth) ->
  item$.css
    opacity: 1

  animations = [
    "bounceInLeft"
    "bounceInRight"
    "bounceInUp"
    "flipUp"
    "rotateInUpLeft"
    "rotateInUpRight"
    "growIn"
  ]

  # Pick a random animation. Make sure it's always less than animations.length.
  animation = animations[Math.floor(Math.random() * animations.length * 0.99)]

  item$.addClass "animated"
  item$.addClass animation
  item$.on 'webkitAnimationEnd', ->
    item$.off 'webkitAnimationEnd'
    item$.removeClass "animated"
    item$.removeClass animation
