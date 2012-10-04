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

      @loadModel()

      requestAnimationFrame @render



    loadModel: ->
      @model = new Model @buffer
      geometry = new THREE.Geometry

      for vertex in @model.frames[1].frame.verts
        geometry.vertices.push new THREE.Vector3(
          @model.header.scale.x * vertex.x + @model.header.translate.x,
          @model.header.scale.y * vertex.y + @model.header.translate.y,
          @model.header.scale.z * vertex.z + @model.header.translate.z
        )

      for triangle in @model.triangles
        geometry.faces.push new THREE.Face3(
          v1 = triangle.vertex[0],
          v2 = triangle.vertex[1],
          v3 = triangle.vertex[2]
        )
        uvs = for i in [0..2]
          vertex = triangle.vertex[i]
          coord  = @model.textureCoordinates[vertex]
          s      = coord.s
          t      = coord.t
          if coord.onSeam and triangle.facesFront
            s += @model.header.skinWidth / 2
          s /= @model.header.skinWidth
          t /= @model.header.skinHeight
          new THREE.UV(s, t)
        geometry.faceVertexUvs[0].push(uvs)


      texture = new THREE.DataTexture(
        @model.skins[0].data24,
        @model.header.skinWidth,
        @model.header.skinHeight,
        THREE.RGBFormat
      )

      @renderer.setFaceCulling(false)

      texture.needsUpdate = yes

      material = new THREE.MeshBasicMaterial(
        #map: texture
        wireframe: yes
      )
      geometry.computeFaceNormals()
      @mesh = new THREE.Mesh geometry, material
      @scene.add @mesh



    render: =>
      @mesh.rotation.x += (2 * Math.PI) / 500
      @mesh.rotation.y += (2 * Math.PI) / 500
      @renderer.render @scene, @camera
      requestAnimationFrame @render
