window.display = {};

window.display.onReadys = [];
window.display.messageHandlers = [];
window.display.callbackHandlers = [];

window.display.controller = null;

window.display.isChromeApp = false;

if chrome?
  if chrome.app.runtime?
    window.display.isChromeApp = true;