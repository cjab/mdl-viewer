define [
  "Three"
  "cs!lib/mdl/mdl"
  "cs!lib/entity"
],

(THREE, Mdl, Entity) ->

  class MdlViewer


    @FRAMES_PER_SECOND = 60


    constructor: (@container, @buffer) ->

      @renderer = new THREE.WebGLRenderer antialias: true
      @container.appendChild @renderer.domElement
      @renderer.setSize @container.offsetWidth, @container.offsetHeight,

      @renderer.setFaceCulling("front")
      @renderer.fps = @FRAMES_PER_SECOND

      @scene  = new THREE.Scene
      @camera = new THREE.PerspectiveCamera(
        45,
        @container.offsetWidth / @container.offsetHeight,
        1,
        40000
      )
      @camera.position.set 0, 0, 100.5

      @entities = []
      @entities.push new Entity(new Mdl(@buffer), @renderer)

      @scene.add entity.mesh for entity in @entities
      for entity in @entities
        entity.mesh.rotation.x = (-2 * Math.PI) / 4

      @intervalId = setInterval @render, (1000 / MdlViewer.FRAMES_PER_SECOND)



    render: =>
      delta = (new Date).getTime() - @lastUpdated
      for entity in @entities
        entity.update()
        entity.mesh.rotation.z += (2 * Math.PI) / 500
        @renderer.render @scene, @camera
      @lastUpdated = (new Date).getTime()
