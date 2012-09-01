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
          expect(model.header).toBeTruthy()

        describe "with a single skin", ->

          it "should read the skin", ->
            expect(model.skins.length).toEqual 1
            expect(model.skins[0]).toBeTruthy()

        describe "with multiple skins", ->

          beforeEach ->
            # Load a model with multiple skins
            modelUrl = "/data/pak0/progs/armor.mdl"
            xhr = new XMLHttpRequest()
            xhr.responseType = "arraybuffer"
            xhr.open "GET", modelUrl
            xhr.onload = (e) -> buffer = xhr.response
            xhr.send()
            waitsFor -> xhr.readyState == 4

          it "should work", -> window.blah = new Model(buffer)

          it "should read all of the skins", ->
            model = new Model(buffer)
            expect(model.skins.length).toEqual model.header.numSkins
            for i in [0...model.header.numSkins]
              expect(model.skins[i]).toBeTruthy()


        it "should read the texture coordinates", ->
          console.log model
          expect(model.textureCoordinates.length).toEqual model.header.numVerts
          expect(model.textureCoordinates[0]).toBeTruthy()
