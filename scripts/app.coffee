define [
  "cs!lib/mdl_viewer"
],

(MdlViewer) ->

  MODELS = [
    'armor', 'backpack', 'bolt', 'bolt2', 'bolt3', 'boss', 'demon', 'dog', 'end1', 'eyes',
    'flame', 'flame2', 'g_light', 'g_nail', 'g_nail2', 'g_rock', 'g_rock2', 'g_shot', 'gib1',
    'gib2', 'gib3', 'grenade', 'h_demon', 'h_dog', 'h_guard', 'h_knight', 'h_ogre', 'h_player',
    'h_shams', 'h_wizard', 'h_zombie', 'invisibl', 'invulner', 'knight', 'lavaball', 'm_g_key',
    'm_s_key', 'missile', 'ogre', 'player', 'quaddama', 's_bubble.spr', 's_explod.spr', 's_light',
    's_light.spr', 's_spike', 'shambler', 'soldier', 'spike', 'suit', 'v_axe', 'v_light',
    'v_nail', 'v_nail2', 'v_rock', 'v_rock2', 'v_shot', 'v_shot2', 'w_g_key', 'w_s_key',
    'w_spike', 'wizard', 'zom_gib', 'zombie'
  ]

  mdlViewer = null
  mdlIndex = 0

  fetch_mdl = (callback) ->
    xhr = new XMLHttpRequest()
    xhr.responseType = "arraybuffer"
    xhr.open "GET", "/data/pak0/progs/#{MODELS[mdlIndex]}.mdl"
    xhr.onload = (e) ->
      callback e.target.response
    xhr.send()

  initialize = ->

    fetch_mdl (modelData) ->
      mdlViewer = new MdlViewer(document.getElementById("container"), modelData)

    document.addEventListener 'keyup', (event) ->
      if event.code == 'ArrowLeft' or event.code == 'ArrowUp'
        mdlIndex += MODELS.length - 1
      else if event.code == 'ArrowRight' or event.code == 'ArrowDown'
        mdlIndex++
      else
        return
      mdlIndex %= MODELS.length
      fetch_mdl (modelData) ->
        mdlViewer.set_mdl_entity_on_scene modelData

  return initialize: initialize
