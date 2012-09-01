define [
  "cs!lib/mdl/header"
],

(Header) ->

  describe "Header", ->

    buffer   = null
    header   = null
    dataView = null
    modelUrl = "/data/pak0/progs/player.mdl"

    beforeEach ->
      xhr = new XMLHttpRequest()
      xhr.responseType = "arraybuffer"
      xhr.open "GET", modelUrl
      xhr.onload = (e) -> buffer = xhr.response
      xhr.send()
      waitsFor -> xhr.readyState == 4


    describe "property", ->

      # TODO: It may be good to test that the underlying buffer is actually
      #       being modified by setters.

      beforeEach ->
        dataView = new DataView(buffer, 0, Header.LENGTH)
        header = new Header(buffer)

      describe "version", ->

        it "should be accessible", ->
          expect(header.version).toEqual Header.VERSION

        it "should be assignable", ->
          header.version = -1
          expect(header.version).toEqual -1

      describe "ident", ->

        it "should be accessible", ->
          expect(header.ident).toEqual Header.IDENT_VALUE

        it "should be assignable", ->
          header.ident = -1
          expect(header.ident).toEqual -1

      describe "boundingRadius", ->

        it "should be accessible", ->
          radius = dataView.getFloat32(32, Header.IS_LITTLE_ENDIAN)
          expect(header.boundingRadius).toBeCloseTo radius

        it "should be assignable", ->
          header.boundingRadius = -1.5
          expect(header.boundingRadius).toEqual -1.5

      describe "numSkins", ->

        it "should be accessible", ->
          numSkins = dataView.getInt32(48, Header.IS_LITTLE_ENDIAN)
          expect(header.numSkins).toEqual numSkins

        it "should be assignable", ->
          header.numSkins = -1
          expect(header.numSkins).toEqual -1

      describe "skinWidth", ->

        it "should be accessible", ->
          skinWidth = dataView.getInt32(52, Header.IS_LITTLE_ENDIAN)
          expect(header.skinWidth).toEqual skinWidth

        it "should be assignable", ->
          header.skinWidth = -1
          expect(header.skinWidth).toEqual -1

      describe "skinHeight", ->

        it "should be accessible", ->
          skinHeight = dataView.getInt32(56, Header.IS_LITTLE_ENDIAN)
          expect(header.skinHeight).toEqual skinHeight

        it "should be assignable", ->
          header.skinHeight= -1
          expect(header.skinHeight).toEqual -1

      describe "numVerts", ->

        it "should be accessible", ->
          numVerts = dataView.getInt32(60, Header.IS_LITTLE_ENDIAN)
          expect(header.numVerts).toEqual numVerts

        it "should be assignable", ->
          header.numVerts = -1
          expect(header.numVerts).toEqual -1

      describe "numTris", ->

        it "should be accessible", ->
          numTris = dataView.getInt32(64, Header.IS_LITTLE_ENDIAN)
          expect(header.numTris).toEqual numTris

        it "should be assignable", ->
          header.numTris = -1
          expect(header.numTris).toEqual -1

      describe "numTris", ->

        it "should be accessible", ->
          numFrames = dataView.getInt32(68, Header.IS_LITTLE_ENDIAN)
          expect(header.numFrames).toEqual numFrames

        it "should be assignable", ->
          header.numFrames = -1
          expect(header.numFrames).toEqual -1

      describe "numTris", ->

        it "should be accessible", ->
          syncType = dataView.getInt32(72, Header.IS_LITTLE_ENDIAN)
          expect(header.syncType).toEqual syncType

        it "should be assignable", ->
          header.syncType = -1
          expect(header.syncType).toEqual -1

      describe "flags", ->

        it "should be accessible", ->
          flags = dataView.getInt32(76, Header.IS_LITTLE_ENDIAN)
          expect(header.flags).toEqual flags

        it "should be assignable", ->
          header.flags = -1
          expect(header.flags).toEqual -1

      describe "size", ->

        it "should be accessible", ->
          size = dataView.getFloat32(80, Header.IS_LITTLE_ENDIAN)
          expect(header.size).toBeCloseTo size

        it "should be assignable", ->
          header.size = -1
          expect(header.size).toEqual -1

      describe "skinSize", ->

        it "should calculate the size in bytes of a skin", ->
          expect(header.skinSize).toEqual(header.skinWidth * header.skinHeight)



    describe "#constructor", ->

      describe "when passed a .mdl file ArrayBuffer", ->

        beforeEach ->
          dataView = new DataView(buffer, 0, Header.LENGTH)
          header   = new Header(buffer)

        it "should create the scale vector", ->
          x = dataView.getFloat32(8,  Header.IS_LITTLE_ENDIAN)
          y = dataView.getFloat32(12, Header.IS_LITTLE_ENDIAN)
          z = dataView.getFloat32(16, Header.IS_LITTLE_ENDIAN)
          expect(header.scale.x).toBeCloseTo x
          expect(header.scale.y).toBeCloseTo y
          expect(header.scale.z).toBeCloseTo z

        it "should create the translate vector", ->
          x = dataView.getFloat32(20, Header.IS_LITTLE_ENDIAN)
          y = dataView.getFloat32(24, Header.IS_LITTLE_ENDIAN)
          z = dataView.getFloat32(28, Header.IS_LITTLE_ENDIAN)
          expect(header.translate.x).toBeCloseTo x
          expect(header.translate.y).toBeCloseTo y
          expect(header.translate.z).toBeCloseTo z

        it "should create the eye position vector", ->
          x = dataView.getFloat32(20, Header.IS_LITTLE_ENDIAN)
          y = dataView.getFloat32(24, Header.IS_LITTLE_ENDIAN)
          z = dataView.getFloat32(28, Header.IS_LITTLE_ENDIAN)
          expect(header.translate.x).toBeCloseTo x
          expect(header.translate.y).toBeCloseTo y
          expect(header.translate.z).toBeCloseTo z


      #TODO: Decide if this will be supported
      #describe "when passed a .mdl url", ->

      #  beforeEach ->
      #    header = new Header(modelUrl)

      #  it "should request the file", ->

      #  it "should read the header", ->

      #  describe "and a callback", ->

      #    it "should call the callback", ->
