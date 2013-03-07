window.display = {};

window.display.onReadys = [];
window.display.messageHandlers = [];
window.display.callbackHandlers = [];

window.display.controller = null;

window.display.isChromeApp = chrome.app.runtime ? true : false;