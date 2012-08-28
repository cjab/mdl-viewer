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


    describe "#constructor", ->

      describe "when passed a .mdl file ArrayBuffer", ->

        beforeEach ->
          dataView = new DataView(buffer, 0, Header.LENGTH)
          header   = new Header(buffer)

        it "should read the version", ->
          expect(header.version).toEqual Header.VERSION

        it "should read the ident value", ->
          expect(header.ident).toEqual Header.IDENT_VALUE

        it "should create the scale vector", ->
          x = dataView.getFloat32(8,  Header.IS_LITTLE_ENDIAN)
          y = dataView.getFloat32(12, Header.IS_LITTLE_ENDIAN)
          z = dataView.getFloat32(16, Header.IS_LITTLE_ENDIAN)
          expect(header.scale.x()).toBeCloseTo x
          expect(header.scale.y()).toBeCloseTo y
          expect(header.scale.z()).toBeCloseTo z

        it "should create the translate vector", ->
          x = dataView.getFloat32(20, Header.IS_LITTLE_ENDIAN)
          y = dataView.getFloat32(24, Header.IS_LITTLE_ENDIAN)
          z = dataView.getFloat32(28, Header.IS_LITTLE_ENDIAN)
          expect(header.translate.x()).toBeCloseTo x
          expect(header.translate.y()).toBeCloseTo y
          expect(header.translate.z()).toBeCloseTo z

        it "should read the bounding radius", ->
          radius = dataView.getFloat32(32, Header.IS_LITTLE_ENDIAN)
          expect(header.boundingRadius).toBeCloseTo radius

        it "should create the eye position vector", ->
          x = dataView.getFloat32(20, Header.IS_LITTLE_ENDIAN)
          y = dataView.getFloat32(24, Header.IS_LITTLE_ENDIAN)
          z = dataView.getFloat32(28, Header.IS_LITTLE_ENDIAN)
          expect(header.translate.x()).toBeCloseTo x
          expect(header.translate.y()).toBeCloseTo y
          expect(header.translate.z()).toBeCloseTo z

        it "should read the number of skins", ->
          numSkins = dataView.getInt32(48, Header.IS_LITTLE_ENDIAN)
          expect(header.numSkins).toEqual numSkins

        it "should read the skin width", ->
          skinWidth = dataView.getInt32(52, Header.IS_LITTLE_ENDIAN)
          expect(header.skinWidth).toEqual skinWidth

        it "should read the skin height", ->
          skinHeight = dataView.getInt32(56, Header.IS_LITTLE_ENDIAN)
          expect(header.skinHeight).toEqual skinHeight

        it "should read the number of vertices", ->
          numVerts = dataView.getInt32(60, Header.IS_LITTLE_ENDIAN)
          expect(header.numVerts).toEqual numVerts

        it "should read the number of triangles", ->
          numTris = dataView.getInt32(64, Header.IS_LITTLE_ENDIAN)
          expect(header.numTris).toEqual numTris

        it "should read the number of frames", ->
          numFrames = dataView.getInt32(68, Header.IS_LITTLE_ENDIAN)
          expect(header.numFrames).toEqual numFrames

        it "should read the sync type", ->
          syncType = dataView.getInt32(72, Header.IS_LITTLE_ENDIAN)
          expect(header.syncType).toEqual syncType

        it "should read the flags", ->
          flags = dataView.getInt32(76, Header.IS_LITTLE_ENDIAN)
          expect(header.flags).toEqual flags

        it "should read the size", ->
          size = dataView.getFloat32(80, Header.IS_LITTLE_ENDIAN)
          expect(header.size).toBeCloseTo size


      #TODO: Decide if this will be supported
      #describe "when passed a .mdl url", ->

      #  beforeEach ->
      #    header = new Header(modelUrl)

      #  it "should request the file", ->

      #  it "should read the header", ->

      #  describe "and a callback", ->

      #    it "should call the callback", ->
