window.control = {};

window.control.onReadys = [];
window.control.messageHandlers = [];
window.control.callbackHandlers = [];
window.control.clickHandlers = [];
window.control.stateHandlers = [];

window.control.display = null;

window.control.isChromeApp = false;

if chrome?
  if chrome.app.runtime?
    window.control.isChromeApp = true;