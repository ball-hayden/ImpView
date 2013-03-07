window.control = {};

window.control.onReadys = [];
window.control.messageHandlers = [];
window.control.callbackHandlers = [];
window.control.clickHandlers = [];
window.control.stateHandlers = [];

window.control.display = null;

window.control.isChromeApp = chrome.app.runtime ? true : false;