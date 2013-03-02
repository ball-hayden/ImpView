display = window.display

emoroco_texts = []

display.messageHandlers.push( (message, target, target$) ->
  return unless message.type == "control"

  switch message.action
    when "emo-add-text"
      text$ = $("<div class='emoroco-text'></div>")
      text$.text(message.value)
      text$.data('id', message.id)

      $('body').append(text$)
      emoroco_texts[message.id] = text$

      text$.center()

      setTimeout( ->
        text$.addClass('transition')

        h = $(window).height() - $(text$).outerHeight();
        w = $(window).width() - $(text$).outerWidth();

        nh = Math.floor(Math.random() * h);
        nw = Math.floor(Math.random() * w);

        text$.css
          top:  nh
          left: nw
          opacity: 0.5
          'font-size': '60px'
      , 500)
    when "emo-focus"
      current$ = $(".emo-focused")
      current$.removeClass('transition')
      current$.fadeOut(1000, ->
        display.sendMessage({ type: "control", action: "emo-remove", id: current$.data('id'), callback: true })
        current$.remove()
      )

      text$ = emoroco_texts[message.id]
      text$.addClass("emo-focused")
      text$.center(2)
      text$.css
        opacity: ''
        'font-size':   ''
    when "emo-remove"
      text$ = emoroco_texts[message.id]
      text$.removeClass('transition')
      text$.fadeOut(1000, ->
        display.sendMessage({ type: "control", action: "emo-remove", id: text$.data('id'), callback: true })
        text$.remove()
      )
    when "emo-change"
      text$ = emoroco_texts[message.id]
      text$.text(message.value)

  return
)

jQuery.fn.center = (multiplier) ->
    multiplier = multiplier || 1
    this.css("position","absolute");
    this.css("top", Math.max(0, (($(window).height() - $(this).outerHeight() * multiplier) / 2) +
                                                $(window).scrollTop()) + "px");
    this.css("left", Math.max(0, (($(window).width() - $(this).outerWidth() * multiplier) / 2) +
                                                $(window).scrollLeft()) + "px");
    return this;