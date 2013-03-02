display = window.display

display.animate = (message, target, target$) ->
  value = message.value

  # Split text by letter
  if message.byLetter
    text = target$.text()

    # Replace &nbsp; with a whitespace
    text = text.replace(/\u00a0/g, " ")

    # Trim trailing whitespace
    text = text.replace(/[ \t]+$/g, "")

    words = text.match(/[\S]*/g)

    $.each words, (i, word) ->
      # Wrap each letter in a div
      word = word.replace(/./g, "<div>$&</div>")

      if word == ""
        word = "&nbsp;"

      words[i] = word
      return

    words = "<div class='word'>" + words.join("</div><div class='word'>") + "</div>"

    target$.html(words);


    if not target$.is(":visible")
      target$.find(".word > div").css({ visibility: 'hidden' })
      target$.show()

    target$.find(".word > div").each (i, item) ->
      item$ = $(item)

      # Reset
      item$.off('webkitAnimationEnd')
      item$.removeClass()

      item$.on('webkitAnimationEnd', ->
        item$.removeClass()

        switch message.after
          when "hide"
            item$.css({ visibility: 'hidden' })

        if i == (target$.find(".word > div").size() - 1)
          # Last element, update the parent
          switch message.after
            when "hide"
              target$.hide()
              target$.find(".word > div").css({ visibility: 'visible' })
          display.sendVisibility(target)

        return
      )

      setTimeout( ->
          item$.addClass("animated")
          item$.addClass(value)
          # Must be visible to run:
          item$.css({ visibility: 'visible' })
          item$.show()
        , i * 100)

      return
  else
    # Reset
    target$.off('webkitAnimationEnd')
    target$.removeClass()

    target$.on('webkitAnimationEnd', ->
      target$.removeClass()

      switch message.after
        when "hide"
          target$.hide()

      display.sendVisibility(target)

      return
    )

    # Must be visible first:
    target$.addClass("animated")
    target$.addClass(value)
    # Must be visible to run:
    target$.show()

  return