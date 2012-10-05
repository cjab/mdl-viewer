define [
  "Three"
  "cs!lib/entity"
  "cs!lib/mdl/model"
],

(THREE, Entity, Model) ->

  describe "Entity", ->

    buffer   = null
    model    = null
    dataView = null
    offset   = null
    renderer = new THREE.WebGLRenderer
    modelUrl = "/data/pak0/progs/player.mdl"
    frame    = null

    beforeEach ->
      xhr = new XMLHttpRequest()
      xhr.responseType = "arraybuffer"
      xhr.open "GET", modelUrl
      xhr.onload = (e) ->
        buffer = xhr.response
        model  = new Model(buffer)
      xhr.send()
      waitsFor -> xhr.readyState == 4


    describe "#constructor", ->

      it "should set the lastUpdated property", ->
        entity = new Entity(model, renderer)
        expect(entity.lastUpdated).toBeTruthy()

      it "should set the mesh property", ->
        entity = new Entity(model, renderer)
        expect(entity.mesh).toBeTruthy()

      it "should set the model property", ->
        entity = new Entity(model, renderer)
        expect(entity.model).toEqual(model)

      it "should set the renderer property", ->
        entity = new Entity(model, renderer)
        expect(entity.renderer).toEqual(renderer)


    describe "#timeSinceUpdate", ->

      it "should return the time elapsed since the last update", ->
        entity = new Entity(model, renderer)
        expected = (new Date).getTime() - entity.lastUpdated
        expect(entity.timeSinceUpdate).toBeCloseTo(expected)
