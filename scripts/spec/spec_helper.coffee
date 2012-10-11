define [
  "Three"
  "cs!lib/entity"
  "cs!lib/mdl/mdl"
],

(THREE, Entity, Mdl) ->

  setup: (context = window) ->
    modelUrl = "/data/pak0/progs/player.mdl"
    context.buffer   = null

    xhr = new XMLHttpRequest()
    xhr.responseType = "arraybuffer"
    xhr.open "GET", modelUrl
    xhr.onload = (e) ->
      context.buffer = xhr.response
      context.model  = new Mdl(context.buffer)
    xhr.send()

    waitsFor -> xhr.readyState == 4
