define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/header"
  "cs!lib/mdl/vertex"
],

(Accessorize, Header, Vertex) ->

  class SimpleFrame

    Accessorize::augment this


    @NAME_LENGTH   = 16
    @VERTEX_OFFSET = (2 * Vertex.LENGTH) + SimpleFrame.NAME_LENGTH


    constructor: (@_dataView, @_numVerts) ->
      @bboxMin = new Vertex(new DataView(
        @_dataView.buffer,
        @_dataView.byteOffset,
        Vertex.LENGTH
      ))
      @bboxMax = new Vertex(new DataView(
        @_dataView.buffer,
        @_dataView.byteOffset + Vertex.LENGTH,
        Vertex.LENGTH
      ))
      @_name = new Uint8Array(
        @_dataView.buffer,
        @_dataView.byteOffset + (2 * Vertex.LENGTH),
        SimpleFrame.NAME_LENGTH
      )
      @verts = @_buildVertices(
        @_dataView.buffer,
        @_dataView.byteOffset + SimpleFrame.VERTEX_OFFSET,
        @_numVerts
      )



    @define 'name'
      # Return the string representation of an array of bytes
      get: ->
        i    = 0
        name = (@_name[i++] while @_name[i] != 0)
        String.fromCharCode.apply null, name

      # Accept a string but store as an array of bytes in the array buffer
      set: (value) ->
        (@_name[i] = value.charCodeAt(i)) for i in [0...value.length]
        @_name[value.length] = 0
        value



    _buildVertices: (buffer, beginOffset, numVerts) ->
      vertices    = []
      for i in [0...numVerts]
        offset       = beginOffset + (i * Vertex.LENGTH)
        vertexView   = new DataView(buffer, offset, Vertex.LENGTH)
        vertices[i]  = new Vertex(vertexView)
