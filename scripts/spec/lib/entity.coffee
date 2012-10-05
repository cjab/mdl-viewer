define [
  "cs!spec/spec_helper"
  "Three"
  "cs!lib/entity"
  "cs!lib/mdl/model"
],

(SpecHelper, THREE, Entity, Model) ->


  describe "Entity", ->

    model    = null
    dataView = null
    offset   = null
    renderer = new THREE.WebGLRenderer
    frame    = null

    beforeEach -> model = new Model(@env.buffer.slice(0))


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
