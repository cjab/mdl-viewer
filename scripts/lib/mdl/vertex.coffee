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


    @define 'x'
      get:       -> @_data[0]
      set: (val) -> @_data[0] = val


    @define 'y'
      get:       -> @_data[1]
      set: (val) -> @_data[1] = val


    @define 'z'
      get:       -> @_data[2]
      set: (val) -> @_data[2] = val
