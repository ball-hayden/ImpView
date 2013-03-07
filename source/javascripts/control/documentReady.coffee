control = window.control
clickHandlers = control.clickHandlers
stateHandlers = control.stateHandlers
onReadys = control.onReadys

$ ->
  if control.isChromeApp
    # We're running as a packaged app.
    chrome.app.window.create 'display.html'
  else
    # Open a new window normally.
    control.display = window.open('display.html', 'ImpView Display');

  $('#loader').text("Waiting for display...");

  $('form').keydown (e) ->
    if e.keyCode == 13
      e.preventDefault();
      return false;

  $.each clickHandlers, (i, handler) ->
    handler();

  $.each stateHandlers, (i, handler) ->
    handler();

  $.each onReadys, (i, onReady) ->
    onReady();

  # Add a confirmation on close
  unless control.isChromeApp
    window.onbeforeunload = ->
      return "Please confirm. This will close the display window."

  unless control.isChromeApp
    window.onunload = ->
      control.display.close()

  if control.isChromeApp
    chrome.app.window.current().maximize();

  return;
