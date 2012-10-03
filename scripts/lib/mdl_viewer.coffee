define [
  "Three"
  "cs!lib/mdl/model"
  "cs!lib/mdl/anorms"
],

(THREE, Model, Anorms) ->

  class MdlViewer

    constructor: (@container, @buffer) ->
      @renderer = new THREE.WebGLRenderer antialias: true
      @container.appendChild @renderer.domElement
      @renderer.setSize @container.offsetWidth, @container.offsetHeight,

      @scene  = new THREE.Scene
      @camera = new THREE.PerspectiveCamera(
        45,
        @container.offsetWidth / @container.offsetHeight,
        1,
        40000
      )
      @camera.position.set 0, 0, 100.5

      @model = new Model @buffer
      geometry = new THREE.Geometry

      for vertex in @model.frames[0].frame.verts
        geometry.vertices.push new THREE.Vector3(
          @model.header.scale.x * vertex.x + @model.header.translate.x,
          @model.header.scale.y * vertex.y + @model.header.translate.y,
          @model.header.scale.z * vertex.z + @model.header.translate.z
        )

      for triangle in @model.triangles
        geometry.faces.push new THREE.Face3(
          triangle.vertex[0],
          triangle.vertex[1],
          triangle.vertex[2]
        )

      material = new THREE.MeshBasicMaterial(
        color:     0xcccccc
        wireframe: true
      )
      @mesh = new THREE.Mesh geometry, material
      @scene.add @mesh

      requestAnimationFrame @render


    render: =>
      @mesh.rotation.x += (2 * Math.PI) / 500
      @mesh.rotation.y += (2 * Math.PI) / 500
      @renderer.render @scene, @camera
      requestAnimationFrame @render
