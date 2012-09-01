define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/header"
],

(Accessorize, Header) ->

  class TextureCoordinate

    Accessorize::augment this


    @LENGTH = 12 # bytes


    constructor: (@_dataView) ->


    @define 'onSeam'
      get:       -> @_dataView.getInt32(0, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_dataView.setInt32(0, val, Header.IS_LITTLE_ENDIAN)


    @define 's'
      get:       -> @_dataView.getInt32(4, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_dataView.setInt32(4, val, Header.IS_LITTLE_ENDIAN)


    @define 't'
      get:       -> @_dataView.getInt32(8, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_dataView.setInt32(8, val, Header.IS_LITTLE_ENDIAN)
