define [
  "cs!lib/mdl/simple_frame"
  "cs!lib/mdl/vertex"
  "cs!lib/mdl/header"
  "cs!lib/mdl/model"
],

(SimpleFrame, Vertex, Header, Model) ->

  describe "SimpleFrame", ->

    buffer      = null
    model       = null
    dataView    = null
    offset      = null
    modelUrl    = "/data/pak0/progs/player.mdl"
    simpleFrame = null

    beforeEach -> buffer = @env.buffer.slice(0)


    describe "property", ->

      beforeEach ->
        model       = new Model(buffer)
        offset      = model.frameOffset + 4 # Move past type flag (int)
        dataView    = new DataView(buffer, offset)
        simpleFrame = new SimpleFrame(dataView, model.header.numVerts)

      describe "bboxMin", ->

        it "should be accessible", ->
          expected = new Vertex(new DataView(buffer, offset, Vertex.LENGTH))
          expect(simpleFrame.bboxMin).toEqual expected

        it "should be assignable", ->
          simpleFrame.bboxMin.normalIndex = 3
          expect(simpleFrame.bboxMin.normalIndex).toEqual 3

      describe "bboxMax", ->

        it "should be accessible", ->
          expected = new Vertex(new DataView(
            buffer,
            offset + Vertex.LENGTH,
            Vertex.LENGTH
          ))
          expect(simpleFrame.bboxMax).toEqual expected

        it "should be assignable", ->
          simpleFrame.bboxMax.normalIndex = 3
          expect(simpleFrame.bboxMax.normalIndex).toEqual 3

      describe "name", ->

        it "should be accessible", ->
          expected = new Uint8Array(
            buffer,
            offset + (2 * Vertex.LENGTH),
            SimpleFrame.NAME_LENGTH
          )
          expect(simpleFrame.name).toEqual expected

        it "should be assignable", ->
          #FIXME: Store anything assigned here in the Uint8 array
          simpleFrame.name = "test"
          expect(simpleFrame.name).toEqual "test"

      describe "verts", ->

        it "should be accessible", ->
          expected = new Vertex(new DataView(
            buffer,
            offset + (2 * Vertex.LENGTH) + SimpleFrame.NAME_LENGTH,
            Vertex.LENGTH
          ))
          expect(simpleFrame.verts[0]).toEqual expected
          expect(simpleFrame.verts.length).toEqual model.header.numVerts

        #it "should be assignable", ->
        #  simpleFrame.verts[0] = "test"
        #  expect(simpleFrame.verts[0]).toEqual "test"
