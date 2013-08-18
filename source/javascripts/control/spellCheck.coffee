control = window.control

client_id = Math.floor(Math.random()* 1000000)
key = "impview-#{client_id}"

control.spellcheck = (text, callback) ->
  atd_url = "http://service.afterthedeadline.com/checkDocument?data=#{text}&key=#{key}"

  responses    = []
  replacements = []

  $.get atd_url, (data) ->
    $data = $(data)
    $errors = $data.find("error")

    if $errors.length == 0
      responses.push text
      return

    $errors.each (i, item) ->
      $item = $(item)
      old   = $item.find("string").text()
      $options = $item.find("option")

      # Maybe one day we could include all options somehow...
      # $options.each (i, item) ->

      option = $options.first().text()
      replacements.push({ old: old, option: option })

    $.each replacements, (i, item) ->
    # responses.push text.replace(item.old, item.option)
      text = text.replace(item.old, item.option)

    #  $.each responses, (i, response) ->
    #    responses.push response.replace(item.old, item.option)

    # To allow multiple responses in the future...
    responses = [text]

    callback unique(responses)

# see http://stackoverflow.com/a/10192255/1322410
unique = (array) ->
  $.grep array, (el, index) ->
    index is $.inArray(el, array)