display       = window.display
LETTER_OFFSET = 13.85

currentRotation = 0
currentLetter   = "a"

messageHandlers = display.messageHandlers

messageHandlers.push (message) ->
  return unless message.type == "control" && message.target == "alphabet"

  target = message.target
  target$ = $('#' + target)

  switch message.action
    when "show"
      target$.removeClass "initial"
      display.sendVisibility(target)
    when "hide"
      target$.css
        "-webkit-transform": ""
      target$.addClass    "initial"
      display.sendVisibility(target)
    when "setStart"
      setLetter(message.value)
    when "next"
      nextLetter()

setLetter = (letter) ->
  currentLetter = letter.toLowerCase()
  aIndex = 97
  index  = currentLetter.charCodeAt(0) - aIndex
  rotation = LETTER_OFFSET * index;
  setRotation(rotation)

  $('#alphabet li').removeClass "current"
  $("#alphabet li:nth-child(#{index + 1})").addClass "current"

nextLetter = ->
  if currentLetter != "z"
    letter = String.fromCharCode(currentLetter.charCodeAt(0) + 1);
  else
    letter = "a"

  setLetter(letter)

setRotation = (rotation) ->
  $('#alphabet').css
    "-webkit-transform": "rotateX(13deg) rotateY(#{rotation}deg)"

  currentRotation = rotation