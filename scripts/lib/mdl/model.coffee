define [
  "cs!lib/mdl/header"
  "cs!lib/mdl/skin"
],

(Header, Skin) ->

  class Model

    constructor: (@buffer) ->
      @header = new Header(@buffer)
      @skins  = @_buildSkins(@buffer, @header)

    _buildSkins: (buffer, header) ->
      skins  = []
      skinObjectSize = header.skinSize + 4
      for i in [0...header.numSkins]
        offset   = Header.LENGTH + (i * skinObjectSize)
        skinView = new DataView(buffer, offset, skinObjectSize)
        skins[i] = new Skin(skinView)
