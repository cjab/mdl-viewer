define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/vector_3"
],

(Accessorize, Vector3) ->

  class Header

    Accessorize::augment this

    @LENGTH:           84 # bytes
    @VERSION:          6
    @IDENT_VALUE:      1330660425 # "IDPO"
    @IS_LITTLE_ENDIAN: yes


    constructor: (buffer) ->
      @_data = new DataView(buffer, 0, Header.LENGTH)

      @scale          = new Vector3(new Float32Array(buffer, 8,  3))
      @translate      = new Vector3(new Float32Array(buffer, 20, 3))
      @eyePosition    = new Vector3(new Float32Array(buffer, 36, 3))


    @define 'ident'
      get:       -> @_data.getInt32(0, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setInt32(0, val, Header.IS_LITTLE_ENDIAN)


    @define 'version'
      get:       -> @_data.getInt32(4, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setInt32(4, val, Header.IS_LITTLE_ENDIAN)


    @define 'boundingRadius'
      get:       -> @_data.getFloat32(32, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setFloat32(32, val, Header.IS_LITTLE_ENDIAN)


    @define 'numSkins'
      get:       -> @_data.getInt32(48, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setInt32(48, val, Header.IS_LITTLE_ENDIAN)


    @define 'skinWidth'
      get:       -> @_data.getInt32(52, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setInt32(52, val, Header.IS_LITTLE_ENDIAN)


    @define 'skinHeight'
      get:       -> @_data.getInt32(56, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setInt32(56, val, Header.IS_LITTLE_ENDIAN)


    @define 'numVerts'
      get:       -> @_data.getInt32(60, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setInt32(60, val, Header.IS_LITTLE_ENDIAN)


    @define 'numTris'
      get:       -> @_data.getInt32(64, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setInt32(64, val, Header.IS_LITTLE_ENDIAN)


    @define 'numFrames'
      get:       -> @_data.getInt32(68, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setInt32(68, val, Header.IS_LITTLE_ENDIAN)


    @define 'syncType'
      get:       -> @_data.getInt32(72, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setInt32(72, val, Header.IS_LITTLE_ENDIAN)


    @define 'flags'
      get:       -> @_data.getInt32(76, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setInt32(76, val, Header.IS_LITTLE_ENDIAN)


    @define 'size'
      get:       -> @_data.getFloat32(80, Header.IS_LITTLE_ENDIAN)
      set: (val) -> @_data.setFloat32(80, val, Header.IS_LITTLE_ENDIAN)


    @define 'skinSize'
      get:       -> @skinWidth * @skinHeight
