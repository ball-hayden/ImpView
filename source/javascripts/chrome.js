// This script allows ImpView to be launched as a chrome app (thanks to
// manifest.json)

chrome.app.runtime.onLaunched.addListener(function() {
  chrome.app.window.create('control.html', {
    type: 'panel'
  });
});