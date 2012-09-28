define [
  "cs!lib/mdl/model"
  "Three"
],

(Model) ->

  initialize = ->
    modelUrl = "/data/pak0/progs/player.mdl"
    xhr = new XMLHttpRequest()
    xhr.responseType = "arraybuffer"
    xhr.open "GET", modelUrl
    xhr.onload = (e) ->
      buffer = xhr.response
      model = new Model buffer
      window.blarg = model
    xhr.send()


  return initialize: initialize
