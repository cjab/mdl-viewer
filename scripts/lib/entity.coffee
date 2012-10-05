define [
  "cs!lib/mixins/accessorize"
],

(Accessorize, Header, SimpleFrame) ->

  class Entity

    Accessorize::augment this


    constructor: (@model, @renderer) ->
      @lastUpdated = (new Date).getTime()
      @mesh = new THREE.Mesh @_loadGeometry(@model), @_loadMaterial(@model)



    # The time that has elapsed since the last call to update was made
    @define 'timeSinceUpdate'
      get: -> (new Date).getTime() - @lastUpdated



    # Load vertices, faces, and uv mapping data from the model object and
    # return a THREE.Geometry object
    _loadGeometry: (model) ->
      geometry = new THREE.Geometry

      for vertex in model.frames[1].frame.verts
        geometry.vertices.push new THREE.Vector3(
          model.header.scale.x * vertex.x + model.header.translate.x,
          model.header.scale.y * vertex.y + model.header.translate.y,
          model.header.scale.z * vertex.z + model.header.translate.z
        )

      for triangle in model.triangles
        geometry.faces.push new THREE.Face3(
          v1 = triangle.vertex[0],
          v2 = triangle.vertex[1],
          v3 = triangle.vertex[2]
        )
        uvs = for i in [0..2]
          vertex = triangle.vertex[i]
          coord  = model.textureCoordinates[vertex]
          s      = coord.s
          t      = coord.t
          if coord.onSeam and triangle.facesFront
            s += model.header.skinWidth / 2
          s /= model.header.skinWidth
          t /= model.header.skinHeight
          new THREE.UV(s, t)
        geometry.faceVertexUvs[0].push(uvs)
      geometry.computeFaceNormals()
      geometry



    # Load textures from the model object and return a THREE.Material object
    _loadMaterial: (model) ->
      texture = new THREE.DataTexture(
        model.skins[0].data24,
        model.header.skinWidth,
        model.header.skinHeight,
        THREE.RGBFormat
      )
      texture.needsUpdate = yes

      material = new THREE.MeshBasicMaterial(
        #map: texture
        wireframe: yes
      )
