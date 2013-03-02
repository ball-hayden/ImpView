display = window.display

$ ->
  display.controller = window.opener;

  $('#loader').text("Waiting for controller...");

  display.sendMessage({ type: "hello" })

  $.each display.onReadys, (i, onReady) ->
    onReady();

  return;
