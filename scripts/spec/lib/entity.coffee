define [
  "Three"
  "cs!lib/entity"
  "cs!lib/mdl/mdl"
],

(THREE, Entity, Mdl) ->


  describe "Entity", ->

    model    = null
    dataView = null
    offset   = null
    renderer = new THREE.WebGLRenderer
    frame    = null

    beforeEach -> model = new Mdl(@env.buffer.slice(0))


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


    describe "#update", ->

      it "should update the interpolation value", ->
        entity = new Entity(model, renderer)
        entity.lastUpdated = (new Date).getTime() - 15
        entity.update()
        expect(entity._interpolation).toNotBe(0)

      # TODO: This text will require a model with more than one frame,
      #       this means more models will need to be loaded.
      #it "should update the current frame value", ->
      #  entity = new Entity(model, renderer)
      #  console.log model.frames.length
      #  entity.lastUpdated = (new Date).getTime() - 3001
      #  entity.update()
      #  expect(entity.currentFrame).toNotBe(0)


    describe "property", ->

      describe "timeSinceUpdate", ->

        it "should return the time elapsed since the last update", ->
          entity = new Entity(model, renderer)
          expected = (new Date).getTime() - entity.lastUpdated
          expect(entity.timeSinceUpdate).toBeCloseTo(expected)

      describe "currentFrame", ->

        it "should return the current frame of the animation", ->
          entity = new Entity(model, renderer)
          expect(entity.currentFrame).toEqual(0)
