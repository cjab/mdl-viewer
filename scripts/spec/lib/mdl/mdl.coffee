define [
  "cs!lib/mdl/mdl"
  "cs!lib/mdl/header"
  "cs!lib/mdl/texture_coordinate"
  "cs!lib/mdl/triangle"
  "cs!lib/mdl/vertex"
],

(Mdl, Header, TextureCoordinate, Triangle, Vertex) ->

  describe "Mdl", ->

    model    = null
    buffer   = null
    dataView = null
    modelUrl = "/data/pak0/progs/player.mdl"

    beforeEach -> buffer = @env.buffer.slice(0)


    describe "#constructor", ->

      describe "when passed a .mdl file ArrayBuffer", ->

        beforeEach ->
          model = new Mdl(buffer)

        it "should read the header", ->
          expect(model.header).toBeTruthy()

        it "should read the frames", ->
          expect(model.frames[0]).toBeTruthy()

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

          it "should read all of the skins", ->
            model = new Mdl(buffer)
            expect(model.skins.length).toEqual model.header.numSkins
            for i in [0...model.header.numSkins]
              expect(model.skins[i]).toBeTruthy()


        it "should read the texture coordinates", ->
          expect(model.textureCoordinates.length).toEqual model.header.numVerts
          expect(model.textureCoordinates[0]).toBeTruthy()


        it "should read the triangles", ->
          expect(model.triangles.length).toEqual model.header.numTris
          expect(model.triangles[0]).toBeTruthy()



    describe "property", ->


      describe "textureOffset", ->

        it "should return the offset in bytes of this model's texture data", ->
          expect(model.textureOffset).toEqual Header.LENGTH



      describe "textureCoordinateOffset", ->

        it "should return the offset in bytes of this model's texture coordinates", ->
          header = new Header(buffer)
          offset = Header.LENGTH + ((header.skinSize + 4) * header.numSkins)
          expect(model.textureCoordinateOffset).toEqual offset


      describe "triangleOffset", ->

        it "should return the offset in bytes of this model's triangle data", ->
          header = new Header(buffer)
          offset = Header.LENGTH +
                   ((header.skinSize + 4) * header.numSkins) +
                   (TextureCoordinate.LENGTH * header.numVerts)
          expect(model.triangleOffset).toEqual offset


      describe "frameOffset", ->

        it "should return the offset in bytes of this model's frame data", ->
          header = new Header(buffer)
          offset = Header.LENGTH +
                   ((header.skinSize + 4) * header.numSkins) +
                   (TextureCoordinate.LENGTH * header.numVerts) +
                   (Triangle.LENGTH * header.numTris)
          expect(model.frameOffset).toEqual offset
