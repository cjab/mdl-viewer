define [
  "cs!lib/mdl_viewer"
],

(MdlViewer) ->


  initialize = ->
    mdlViewer  = null
    modelUrl   = "/data/pak0/progs/player.mdl"

    xhr = new XMLHttpRequest()
    xhr.responseType = "arraybuffer"

    xhr.open "GET", modelUrl
    xhr.onload = (e) ->
      modelData = e.target.response
      new MdlViewer(document.getElementById("container"), modelData)
    xhr.send()


  return initialize: initialize
