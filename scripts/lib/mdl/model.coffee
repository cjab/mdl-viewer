define [
  "cs!lib/mdl/header"
  "cs!lib/mdl/skin"
  "cs!lib/mdl/texture_coordinate"
],

(Header, Skin, TextureCoordinate) ->

  class Model

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
      beginOffset = Header.LENGTH + (header.numSkins * (header.skinSize + 4))
      for i in [0...header.numVerts]
        offset    = beginOffset + (i * TextureCoordinate.LENGTH)
        coordView = new DataView(buffer, offset, TextureCoordinate.LENGTH)
        textureCoordinates[i] = new TextureCoordinate(coordView)
