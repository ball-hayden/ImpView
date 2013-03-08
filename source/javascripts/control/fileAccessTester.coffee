errorModal = $("""
              <div class="modal hide fade">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                  <h3>Warning</h3>
                </div>
                <div class="modal-body">
                  <p>ImpView files cannot be loaded by javascript.</p>
                  <p>This prevents most things from working correctly (but feel free to try anyway).</p>
                  <p>
                    If you are running this from a file rather than a server or as a chrome app, this may be
                    because your browser prevents access to files from files (!).
                    <br />
                    In Chrome, this can be corrected by adding the <code>--allow-file-access-from-files</code>
                    flag.
                  </p>
                  <p>Don't shoot the messenger (blame CSP).</p>
                </div>
                <div class="modal-footer">
                  <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">Close</a>
                </div>
              </div>
               """)

control = window.control

control.onReadys.push ->
  # Attempt to get i.png
  $.ajax
    url: "content/i.png",
    error: ->
      $("body").append(errorModal)
      $(errorModal).modal()
