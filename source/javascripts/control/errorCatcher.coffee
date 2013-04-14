control = window.control

window.onerror = (msg, url, line) ->
  control.showError(msg, url, line, "Unknown")

control.callbackHandlers.push (message) ->
  # Image specific callback handlers
  return unless message.target == "window" && message.type == "error"

  control.showError(message.msg, message.url, message.line, message.trace)

control.showError = (msg, url, line, trace) ->
  errorModal = $("""
              <div class="modal hide fade">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                  <h3>Well... this is embarrassing</h3>
                </div>
                <div class="modal-body">
                  <p>
                    *Please* report this
                    <a href="http://redmine.haydenball.me.uk/projects/impview/issues/new">here</a>.
                    Don't forget to include your browser version and all of the details below. Thanks.
                  </p>

                  <hr />

                  <p>An error has occurred in #{url} on line #{line}</p>
                  <pre>
#{msg}
                  </pre>

                  Trace:
                  <pre>
#{trace}
                  </pre>
                  <p>Sorry.</p>
                </div>
                <div class="modal-footer">
                  <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">Close</a>
                </div>
              </div>
               """)

  $("body").append(errorModal)
  $(errorModal).modal()