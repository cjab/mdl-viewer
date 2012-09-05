define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/header"
  "cs!lib/mdl/skin"
  "cs!lib/mdl/texture_coordinate"
  "cs!lib/mdl/triangle"
  "cs!lib/mdl/vertex"
],

(Accessorize, Header, Skin, TextureCoordinate, Triangle, Vertex) ->

  class Model

    Accessorize::augment this

    constructor: (@_buffer) ->
      @header             = new Header(@_buffer)
      @skins              = @_buildSkins(@_buffer, @header)
      @textureCoordinates = @_buildTextureCoordinates(@_buffer, @header)


    _buildSkins: (buffer, header) ->
      skins  = []
      skinObjectSize = header.skinSize + 4
      for i in [0...header.numSkins]
        offset   = Header.LENGTH + (i * skinObjectSize)
        skinView = new DataView(buffer, offset, skinObjectSize)
        skins[i] = new Skin(skinView)


    _buildTextureCoordinates: (buffer, header) ->
      textureCoordinates = []
      for i in [0...header.numVerts]
        offset    = @textureCoordinateOffset + (i * TextureCoordinate.LENGTH)
        coordView = new DataView(buffer, offset, TextureCoordinate.LENGTH)
        textureCoordinates[i] = new TextureCoordinate(coordView)


    @define 'textureOffset'
      get: -> Header.LENGTH


    @define 'textureCoordinateOffset'
      get: -> @textureOffset +
              ((@header.skinSize + 4) * @header.numSkins)


    @define 'triangleOffset'
      get: -> @textureCoordinateOffset +
              (TextureCoordinate.LENGTH * @header.numVerts)


    @define 'vertexOffset'
      get: -> @triangleOffset +
              (Triangle.LENGTH * @header.numTris)


    @define 'frameOffset'
      get: -> @vertexOffset +
              (Vertex.LENGTH * @header.numVerts)
