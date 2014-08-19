$ ->
  split = (val) ->
    val.split /,\s*/
  extractLast = (term) ->
    split(term).pop()
  
  # don't navigate away from the field on tab when selecting an item
  $(".tags_field").bind("keydown", (event) ->
    event.preventDefault()  if event.keyCode is $.ui.keyCode.TAB and $(this).autocomplete("instance").menu.active
    return
  ).autocomplete
    minLength: 1,
    source: (request, response) ->
      $.getJSON "/find_tags",
        term: extractLast(request.term)
      , response
      return
    search: ->
      # custom minLength
      term = extractLast(@value)
      false  if term.length < 2
    focus: ->
      # prevent value inserted on focus
      false
    select: (event, ui) ->
      terms = split(@value)
      # remove the current input
      terms.pop()
      # add the selected item
      terms.push ui.item.value
      # add placeholder to get the comma-and-space at the end
      terms.push ""
      @value = terms.join(", ")
      false
  return
