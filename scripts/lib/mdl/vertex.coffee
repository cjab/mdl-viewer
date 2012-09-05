define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/header"
],

(Accessorize, Header) ->

  class Vertex

    Accessorize::augment this


    @LENGTH = 4 # bytes


    constructor: (@_dataView) ->
      @_data = new Uint8Array(
        @_dataView.buffer,
        @_dataView.byteOffset,
        @_dataView.byteLength
      )


    @define 'coordinates'
      get: -> @_data


    @define 'normalIndex'
      get:       -> @_dataView.getUint8(3, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_dataView.setUint8(3, val, Header.IS_LITTLE_ENDIAN)
