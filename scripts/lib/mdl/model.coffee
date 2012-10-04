define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/header"
  "cs!lib/mdl/skin"
  "cs!lib/mdl/texture_coordinate"
  "cs!lib/mdl/triangle"
  "cs!lib/mdl/vertex"
  "cs!lib/mdl/frame"
],

(Accessorize, Header, Skin, TextureCoordinate, Triangle, Vertex, Frame) ->

  class Model

    Accessorize::augment this


    constructor: (@_buffer) ->
      @header             = new Header(@_buffer)
      @skins              = @_buildSkins(@_buffer, @header)
      @textureCoordinates = @_buildTextureCoordinates(@_buffer, @header)
      @triangles          = @_buildTriangles(@_buffer, @header)
      @frames             = @_buildFrames(@_buffer, @header)


    _buildSkins: (buffer, header) ->
      skins  = []
      skinObjectSize = header.skinSize + 4
      for i in [0...header.numSkins]
        offset   = Header.LENGTH + (i * skinObjectSize)
        skinView = new DataView(buffer, offset, skinObjectSize)
        skins[i] = new Skin(skinView, @header.skinWidth, @header.skinHeight)


    _buildTextureCoordinates: (buffer, header) ->
      textureCoordinates = []
      for i in [0...header.numVerts]
        offset    = @textureCoordinateOffset + (i * TextureCoordinate.LENGTH)
        coordView = new DataView(buffer, offset, TextureCoordinate.LENGTH)
        textureCoordinates[i] = new TextureCoordinate(coordView)


    _buildTriangles: (buffer, header) ->
      triangles = []
      for i in [0...header.numTris]
        offset       = @triangleOffset + (i * Triangle.LENGTH)
        triangleView = new DataView(buffer, offset, Triangle.LENGTH)
        triangles[i] = new Triangle(triangleView)


    _buildFrames: (buffer, header) ->
      frames = []
      # FIXME: It feels like the frame should be responsible for computing this.
      #        The problem is without the header it's not known how many verts
      #        there will be.
      frameLength = 4 + (Vertex.LENGTH * 2) + 16 + (header.numVerts * Vertex.LENGTH)
      for i in [0...header.numFrames]
        offset    = @frameOffset + (i * frameLength)
        result = offset + frameLength
        frameView = new DataView buffer, offset, frameLength
        frames[i] = new Frame(frameView, header.numVerts)


    @define 'textureOffset'
      get: -> Header.LENGTH


    @define 'textureCoordinateOffset'
      get: -> @textureOffset +
              ((@header.skinSize + 4) * @header.numSkins)


    @define 'triangleOffset'
      get: -> @textureCoordinateOffset +
              (TextureCoordinate.LENGTH * @header.numVerts)


    @define 'frameOffset'
      get: -> @triangleOffset +
              (Triangle.LENGTH * @header.numTris)
