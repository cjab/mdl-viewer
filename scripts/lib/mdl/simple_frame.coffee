define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/header"
  "cs!lib/mdl/vertex"
],

(Accessorize, Header, Vertex) ->

  class SimpleFrame

    Accessorize::augment this


    @NAME_LENGTH = 16


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
      #FIXME: Store anything assigned to name in the Uint8 array
      @name = new Uint8Array(
        @_dataView.buffer,
        @_dataView.byteOffset + (2 * Vertex.LENGTH),
        SimpleFrame.NAME_LENGTH
      )
      @verts = @_buildVertices(
        @_dataView.buffer,
        @_dataView.byteOffset + (2 * Vertex.LENGTH) + SimpleFrame.NAME_LENGTH,
        @_numVerts
      )


    _buildVertices: (buffer, beginOffset, numVerts) ->
      vertices    = []
      for i in [0...numVerts]
        offset       = beginOffset + (i * Vertex.LENGTH)
        vertexView   = new DataView(buffer, offset, Vertex.LENGTH)
        vertices[i]  = new Vertex(vertexView)
