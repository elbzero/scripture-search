$.fn.serializeObject = ->
  o = {}
  a = @serializeArray()
  $.each a, ->
    if o[@name] isnt `undefined`
      o[@name] = [o[@name]]  unless o[@name].push
      o[@name].push @value or ""
    else
      o[@name] = @value or ""
    return

  o

secondstotime = (secs) ->
  t = new Date(1970, 0, 1)
  t.setSeconds secs
  s = t.toTimeString().substr(0, 8)
  s = Math.floor((t - Date.parse("1/1/70")) / 3600000) + s.substr(2)  if secs > 86399
  s