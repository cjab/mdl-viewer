define [
  "cs!lib/mdl/frame"
  "cs!lib/mdl/header"
  "cs!lib/mdl/model"
  "cs!lib/mdl/simple_frame"
],

(Frame, Header, Model, SimpleFrame) ->

  describe "Frame", ->

    buffer   = null
    model    = null
    dataView = null
    offset   = null
    modelUrl = "/data/pak0/progs/player.mdl"
    frame    = null

    beforeEach ->
      xhr = new XMLHttpRequest()
      xhr.responseType = "arraybuffer"
      xhr.open "GET", modelUrl
      xhr.onload = (e) -> buffer = xhr.response
      xhr.send()
      waitsFor -> xhr.readyState == 4


    describe "property", ->

      beforeEach ->
        model    = new Model(buffer)
        offset   = model.frameOffset
        dataView = new DataView(buffer, offset)
        frame    = new Frame(dataView)

      describe "type", ->

        it "should be accessible", ->
          expected = dataView.getInt32(0, Header.IS_LITTLE_ENDIAN)
          expect(frame.type).toEqual expected

        it "should be assignable", ->
          frame.type = 3
          expect(frame.type).toEqual 3

      describe "frame", ->

        it "should be accessible", ->
          offset   = model.frameOffset + 4 # Move past type flag (int)
          data     = new DataView(buffer, offset)
          expected = new SimpleFrame(data, model.header.numVerts)
          expect(frame.frame.name).toEqual expected.name

        #it "should be assignable", ->
        #  frame.type = 3
        #  expect(frame.type).toEqual 3
