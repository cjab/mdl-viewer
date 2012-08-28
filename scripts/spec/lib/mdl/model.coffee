define [
  "cs!lib/mdl/model"
],

(Model) ->

  describe "Model", ->

    model    = null
    buffer   = null
    dataView = null
    modelUrl = "/data/pak0/progs/player.mdl"

    beforeEach ->
      xhr = new XMLHttpRequest()
      xhr.responseType = "arraybuffer"
      xhr.open "GET", modelUrl
      xhr.onload = (e) -> buffer = xhr.response
      xhr.send()
      waitsFor -> xhr.readyState == 4

    describe "#constructor", ->

      describe "when passed a .mdl file ArrayBuffer", ->

        beforeEach ->
          model = new Model(buffer)

        it "should read the header", ->
          expect(model.header).not.toBeFalsy()
