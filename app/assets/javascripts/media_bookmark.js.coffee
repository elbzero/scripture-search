startBookmarkAt = (start_at) ->
  startTime = $(start_at).data("start-time") 
  audio = $("audio")[0]
  if audio.readyState >= 3 
    audio.currentTime = parseFloat( startTime )
    audio.play()
  else
    event = ->
      startBookmarkAt start_at
    window.queuedEvents.push event

window.queuedEvents = []

$(document).ready ->
  $(".add-bookmark").click ->
    dialog.dialog "open"
    media_file = $(".add-bookmark").data("audio-file")
    audio = $("audio")[0]
    audio.pause()
    
  $(".audio-bookmark").click ->
    startBookmarkAt($(this))

  $("audio").bind "canplay", ->
    _(queuedEvents).forEach (event) ->
      event()

  $(".start_at").each (item) ->
    startBookmarkAt($(this))

  addBookmark = ->
    audio = $("audio")[0]
    media_file = $(".add-bookmark").data("audio-file")
    form = dialog.find("form")
    $("input[name=startTime]").val( audio.currentTime )
    data = form.serializeObject()
    $.ajax "/add_bookmark",
      type : "POST"
      data : data
      success : (data, status, jqXHR ) ->
        dialog.dialog "close"

  dialog = $("#dialog-form").dialog(
    autoOpen: false
    height: 400
    width: 500
    modal: true
    position: 
      my: "center"
      at: "center"
      of: window
    buttons: [
      text: "Add Bookmark"
      click: addBookmark
      class: "btn btn-success"
    ],
      Cancel: ->
        dialog.dialog "close"
        return

    close: ->
      form[0].reset()
      # allFields.removeClass "ui-state-error"
      return
  )

  $("#create-user").button().on "click", ->
    dialog.dialog "open"
    return

  form = dialog.find("form").on("submit", (event) ->
    event.preventDefault()
    # addUser()
    return
  )


