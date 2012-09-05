define [
  "cs!lib/mdl/vertex"
  "cs!lib/mdl/header"
  "cs!lib/mdl/model"
],

(Vertex, Header, Model) ->

  describe "Vertex", ->

    buffer   = null
    model    = null
    dataView = null
    offset   = null
    modelUrl = "/data/pak0/progs/player.mdl"
    vertex   = null

    beforeEach ->
      xhr = new XMLHttpRequest()
      xhr.responseType = "arraybuffer"
      xhr.open "GET", modelUrl
      xhr.onload = (e) -> buffer = xhr.response
      xhr.send()
      waitsFor -> xhr.readyState == 4


    describe "property", ->

      beforeEach ->
        model = new Model(buffer)
        #TODO: Calculate proper offset
        offset     = model.vertexOffset
        dataView   = new DataView(buffer, offset, Vertex.LENGTH)
        vertex     = new Vertex(dataView)

      describe "normalIndex", ->

        it "should be accessible", ->
          expected = dataView.getUint8(0, Header.IS_LITTLE_ENDIAN)
          expect(vertex.normalIndex).toEqual expected

        it "should be assignable", ->
          vertex.normalIndex = 3
          expect(vertex.normalIndex).toEqual 3

      describe "coordinates", ->

        it "should be accessible", ->
          expected = new Uint8Array(buffer, offset, 3)
          expect(vertex.coordinates[0]).toEqual expected[0]
          expect(vertex.coordinates[1]).toEqual expected[1]
          expect(vertex.coordinates[2]).toEqual expected[2]

        it "should be assignable", ->
          vertex.coordinates[0] = 3
          vertex.coordinates[1] = 4
          vertex.coordinates[2] = 5
          expect(vertex.coordinates[0]).toEqual 3
          expect(vertex.coordinates[1]).toEqual 4
          expect(vertex.coordinates[2]).toEqual 5
