define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/header"
  "cs!lib/mdl/simple_frame"
],

(Accessorize, Header, SimpleFrame) ->

  class Frame

    Accessorize::augment this


    constructor: (@_dataView, @_numVerts) ->
      @frame = new SimpleFrame(new DataView(
        @_dataView.buffer,
        @_dataView.byteOffset + 4, # Move past type int
      ), @_numVerts )


    @define 'type'
      get:       -> @_dataView.getInt32(0, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_dataView.setInt32(0, val, Header.IS_LITTLE_ENDIAN)
