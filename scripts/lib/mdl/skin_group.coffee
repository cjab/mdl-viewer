define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/header"
],

(Accessorize, Header) ->

  class SkinGroup

    Accessorize::augment this


    constructor: (@_dataView) ->
      throw "Not a SkinGroup, possibly a Skin" if @group == 0
      @data = new Uint8Array(
        @_dataView.buffer,
        @_dataView.byteOffset + 4,
        @_dataView.byteLength - 4
      )


    @define 'group'
      get:       -> @_dataView.getInt32(0, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_dataView.setInt32(0, val, Header.IS_LITTLE_ENDIAN)
