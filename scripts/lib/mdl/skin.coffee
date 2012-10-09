define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/header"
  "cs!lib/mdl/palette"
],

(Accessorize, Header, PALETTE) ->

  class Skin

    Accessorize::augment this


    constructor: (@_dataView, @width, @height) ->
      throw "Not a Skin, possibly a SkinGroup" if @group == 1
      @data = new Uint8Array(
        @_dataView.buffer,
        @_dataView.byteOffset + 4,
        @_dataView.byteLength - 4
      )


    @define 'group'
      get:       -> @_dataView.getInt32(0, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_dataView.setInt32(0, val, Header.IS_LITTLE_ENDIAN)


    @define 'size'
      get:       -> @_dataView.byteLength


    @define 'data24'
      get: ->
        bytes  = 3
        buffer = new Uint8Array(@width * @height * bytes)
        for i in [0...@data.length]
          begin = i * bytes
          buffer[begin    ] = (PALETTE[@data[i]] & 0xff0000) >> 16
          buffer[begin + 1] = (PALETTE[@data[i]] & 0x00ff00) >>  8
          buffer[begin + 2] =  PALETTE[@data[i]] & 0x0000ff
        buffer
