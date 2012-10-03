define [
  "cs!lib/mdl_viewer"
  "cs!lib/mdl/model"
  "Three"
],

(MdlViewer, Model, THREE) ->


  initialize = ->
    mdlViewer = null
    modelUrl  = "/data/pak0/progs/player.mdl"

    xhr = new XMLHttpRequest()
    xhr.responseType = "arraybuffer"
    xhr.open "GET", modelUrl
    xhr.onload = (e) ->
      new MdlViewer document.getElementById("container"), xhr.response
    xhr.send()


  return initialize: initialize
