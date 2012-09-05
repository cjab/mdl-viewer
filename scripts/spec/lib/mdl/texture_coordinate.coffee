define [
  "cs!lib/mdl/texture_coordinate"
  "cs!lib/mdl/header"
],

(TextureCoordinate, Header) ->

  describe "TextureCoordinate", ->

    buffer     = null
    header     = null
    dataView   = null
    modelUrl   = "/data/pak0/progs/player.mdl"
    coordinate = null

    beforeEach ->
      xhr = new XMLHttpRequest()
      xhr.responseType = "arraybuffer"
      xhr.open "GET", modelUrl
      xhr.onload = (e) -> buffer = xhr.response
      xhr.send()
      waitsFor -> xhr.readyState == 4


    describe "property", ->

      beforeEach ->
        header     = new Header(buffer)
        offset     = Header.LENGTH + ((header.skinSize + 4) * header.numSkins)
        dataView   = new DataView(buffer, offset, TextureCoordinate.LENGTH)
        coordinate = new TextureCoordinate(dataView)

      describe "onSeam", ->

        it "should be accessible", ->
          expected = dataView.getInt32(0, Header.IS_LITTLE_ENDIAN)
          expect(coordinate.onSeam).toEqual expected

        it "should be assignable", ->
          coordinate.onSeam = -1
          expect(coordinate.onSeam).toEqual -1

      describe "s", ->

        it "should be accessible", ->
          expected = dataView.getInt32(4, Header.IS_LITTLE_ENDIAN)
          expect(coordinate.s).toEqual expected

        it "should be assignable", ->
          coordinate.s= -1
          expect(coordinate.s).toEqual -1

      describe "t", ->

        it "should be accessible", ->
          expected = dataView.getInt32(8, Header.IS_LITTLE_ENDIAN)
          expect(coordinate.t).toEqual expected

        it "should be assignable", ->
          coordinate.t = -1
          expect(coordinate.t).toEqual -1
