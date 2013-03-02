control = window.control
clickHandlers = control.clickHandlers
sendMessage = control.sendMessage

clickHandlers.push ->
  $('.animate-control').click (e) ->
    btn$ = $(e.target)
    sendMessage({
                 type: "control",
                 target: btn$.data('target'),
                 action: "animate",
                 value: btn$.data('animation'),
                 before: btn$.data('before'),
                 after: btn$.data('after'),
                 byLetter: btn$.data('by-letter')
                })
    return

  $('.toggle-class').click (e) ->
    btn$ = $(e.target)
    sendMessage({
                 type: "control",
                 target: btn$.data('target'),
                 action: "toggle-class",
                 value: btn$.data("animation")
                })