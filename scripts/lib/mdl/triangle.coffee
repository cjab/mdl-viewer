define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/header"
],

(Accessorize, Header) ->

  class Triangle

    Accessorize::augment this


    @LENGTH = 16 # bytes


    constructor: (@_dataView) ->
      @_vertex = new Int32Array(
        @_dataView.buffer,
        @_dataView.byteOffset + 4,
        12
      )


    @define 'vertex'
      get: -> @_vertex


    @define 'facesFront'
      get:       -> @_dataView.getInt32(0, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_dataView.setInt32(0, val, Header.IS_LITTLE_ENDIAN)
