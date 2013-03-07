control = window.control

emo_entries = []
emotions = []

loadErrorModal = $("""
                  <div class="modal hide fade">
                    <div class="modal-header">
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                      <h3>Warning</h3>
                    </div>
                    <div class="modal-body">
                      <p>The emotions list could not be loaded.</p>
                      <p>You can safely ignore this, but you won't get the emotions typeahead for EmoRoCo.</p>
                      <p>
                        If you are running this from a file rather than a server, this may be because your
                        browser prevents access to files from files (!).
                        <br />
                        In Chrome, this can be corrected by adding the <code>--allow-file-access-from-files</code>
                        flag.
                      </p>
                      <p>Don't shoot the messenger.</p>
                    </div>
                    <div class="modal-footer">
                      <a href="#" class="btn" data-dismiss="modal" aria-hidden="true">Close</a>
                    </div>
                  </div>
                   """)

control.callbackHandlers.push( (message) ->
  return unless message.type == "control"

  switch message.action
    when "emo-remove"
      entry$ = emo_entries[message.id]
      entry$.slideUp(500, ->
        entry$.remove
      )

  return
)

addEmorocoHandlers = (selector) ->
  # Add the typeahead
  text$ = $(selector).find('.emoroco-text')
  text$.typeahead(
      source: (query, process) ->
        # Copy the emotions array
        list = emotions.slice(0)

        # Add the current query to the data.
        list.unshift(query)

        process(list)

        # Scroll to the bottom of the list
        typeahead$ = $(selector).find('.typeahead')
        window.scrollTo(0, typeahead$.offset().top);

        return
    )

  $(selector).find('.emoroco-text').on('keyup', (e) ->
    emorocoEnterHandler(e)
    return
  )

  $(selector).find('.emoroco-focus').click (e) ->
    target$ = $(e.target)
    control.sendMessage({ type: "control", action: "emo-focus", id: target$.closest('.emoroco-entry').data('id') })
    return

  $(selector).find('.emoroco-remove').click (e) ->
    target$ = $(e.target)
    control.sendMessage({ type: "control", action: "emo-remove", id: target$.closest('.emoroco-entry').data('id') })
    return

  return

emorocoCorrectionHandler = (e) ->
  e.preventDefault() if e.keyCode == 13

  target$ = $(e.target)
  control.sendMessage({ type: "control", action: "emo-change", value: target$.val(), id: target$.closest('.emoroco-entry').data('id') })

  return false

emorocoEnterHandler = (e) ->
  return unless e.keyCode == 13

  e.preventDefault()

  target$ = $(e.target)

  target$.off('keyup')
  target$.on('keyup', (e) ->
    emorocoCorrectionHandler(e)
    return
  )

  id = target$.closest('.emoroco-entry').data('id')
  emo_entries[id] = target$.closest('.emoroco-entry')

  control.sendMessage({ type: "control", action: "emo-add-text", value: target$.val(), id: id })

  # Create a new entry
  newEntry = $('.emoroco-entry').first().clone()
  newEntry.show() # If the first one has already been used.
  newEntry.find("input").val('')
  newEntry.data('id', emo_entries.length)

  # Prevent the form from submitting
  $(newEntry).keydown (e) ->
    if e.keyCode == 13
      e.preventDefault();
      return false;

  $('.emoroco-group').append(newEntry)

  addEmorocoHandlers(newEntry)

  newEntry.find("input").focus()

  return false

control.onReadys.push( ->
  addEmorocoHandlers('.emoroco-group')

  $('#emoroco-remove-all').click ->
    $('.emoroco-entry').each (i, target) ->
      target$ = $(target)
      control.sendMessage({ type: "control", action: "emo-remove", id: target$.data('id') })

  # Fetch the emotions list:
  $.ajax
    url: 'content/emotions.json',
    dataType: 'json',
    success: (data) ->
      emotions = data
    error: ->
      $("body").append(loadErrorModal)
      $(loadErrorModal).modal()

  return
)