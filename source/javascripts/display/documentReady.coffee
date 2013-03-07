display = window.display

$ ->
  display.controller = window.opener;

  $('#loader').text("Waiting for controller...");

  display.sendMessage({ type: "hello" })

  $.each display.onReadys, (i, onReady) ->
    onReady();

  if display.isChromeApp
    chrome.app.window.current().maximize();

  $('body').keypress (e) ->
    return unless e.keyCode == 32

    if document.webkitIsFullScreen
      document.webkitCancelFullScreen();
    else
      document.body.webkitRequestFullscreen();

  return;
