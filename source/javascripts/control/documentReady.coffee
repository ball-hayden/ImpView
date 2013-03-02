control = window.control
clickHandlers = control.clickHandlers
stateHandlers = control.stateHandlers
onReadys = control.onReadys

$ ->
  control.display = window.open('display.html','ImpView Display');

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
  #window.onbeforeunload = ->
  #  return "Please confirm. This will close the display window."

  window.onunload = ->
    control.display.close()

  return;
