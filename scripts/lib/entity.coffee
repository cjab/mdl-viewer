define [
  "cs!lib/mixins/accessorize"
],

(Accessorize, Header, SimpleFrame) ->

  class Entity

    Accessorize::augment this

    @ANIMATION_RATE = 100



    constructor: (@model, @renderer) ->
      @animate        = yes
      @currentFrame   = 0
      @_interpolation = 0.0
      @lastUpdated    = (new Date).getTime()
      @mesh = new THREE.Mesh @_loadGeometry(@model), @_loadMaterial(@model)



    # The time that has elapsed since the last call to update was made
    @define 'timeSinceUpdate'
      get: -> (new Date).getTime() - @lastUpdated



    # Update and animate the entity's model
    update: ->
      if @animate
        @_updateInterpolation()
        @_updateVertices()
      @lastUpdated = (new Date).getTime()



    _updateVertices: ->
      for i in [0...@mesh.geometry.vertices.length]
        start  = @model.frames[@currentFrame].frame.verts[i]
        end    = @model.frames[(@currentFrame + 1) % @model.frames.length].frame.verts[i]
        dx     = (end.x - start.x) * @model.header.scale.x
        dy     = (end.y - start.y) * @model.header.scale.y
        dz     = (end.z - start.z) * @model.header.scale.z
        x = (@model.header.scale.x * start.x) + dx + @model.header.translate.x
        y = (@model.header.scale.y * start.y) + dy + @model.header.translate.y
        z = (@model.header.scale.z * start.z) + dz + @model.header.translate.z
        @mesh.geometry.vertices[i].set(x, y, z)
      @mesh.geometry.verticesNeedUpdate = true



    # Update the interpolation value based on the time that has passed since
    # the last update.
    _updateInterpolation: ->
      @_interpolation += @timeSinceUpdate / Entity.ANIMATION_RATE
      fullFrames       = Math.floor(@_interpolation)
      if @_interpolation >= 1
        @currentFrame = (@currentFrame + fullFrames) % @model.frames.length
        @_interpolation = @_interpolation - fullFrames



    # Load vertices, faces, and uv mapping data from the model object and
    # return a THREE.Geometry object
    _loadGeometry: (model) ->
      geometry = new THREE.Geometry

      for vertex in model.frames[@currentFrame].frame.verts
        geometry.vertices.push new THREE.Vector3(
          model.header.scale.x * vertex.x + model.header.translate.x,
          model.header.scale.y * vertex.y + model.header.translate.y,
          model.header.scale.z * vertex.z + model.header.translate.z
        )

      for triangle in model.triangles
        geometry.faces.push new THREE.Face3(
          triangle.vertex[0],
          triangle.vertex[1],
          triangle.vertex[2]
        )
        uvs = for i in [0..2]
          vertex = triangle.vertex[i]
          coord  = model.textureCoordinates[vertex]
          s      = coord.s
          t      = coord.t
          if coord.onSeam and not triangle.facesFront
            s += model.header.skinWidth / 2
          u = (s + 0.5) / model.header.skinWidth
          v = (t + 0.5) / model.header.skinHeight
          new THREE.UV(u, v)
        geometry.faceVertexUvs[0].push(uvs)
      geometry



    # Load textures from the model object and return a THREE.Material object
    _loadMaterial: (model) ->
      texture = new THREE.DataTexture(
        model.skins[0].data24,
        model.header.skinWidth,
        model.header.skinHeight,
        THREE.RGBFormat
      )
      texture.flipY       =  no
      texture.needsUpdate = yes

      material = new THREE.MeshBasicMaterial(
        map: texture
        #color:     "333333"
        #wireframe: yes
      )
