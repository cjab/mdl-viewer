define [
  "cs!lib/mdl/skin_group"
  "cs!lib/mdl/header"
],

(SkinGroup, Header) ->

  describe "SkinGroup", ->

    buffer    = null
    header    = null
    skinGroup = null
    dataView  = null
    #TODO: Find an example of a model with a skin group :\ Without a working
    #      model to test this spec is kind of useless.
    modelUrl  = "/data/pak0/progs/player.mdl"

    beforeEach ->
      xhr = new XMLHttpRequest()
      xhr.responseType = "arraybuffer"
      xhr.open "GET", modelUrl
      xhr.onload = (e) -> buffer = xhr.response
      xhr.send()
      waitsFor -> xhr.readyState == 4

    #describe "property", ->

    #  beforeEach ->
    #    header    = new Header(buffer)
    #    dataView  = new DataView(buffer, Header.LENGTH, header.skinSize)
    #    skinGroup = new SkinGroup(dataView)

    #  describe "group", ->

    #    it "should be accessible", ->
    #      skinGroup.group = 1
    #      expect(skinGroup.group).toEqual 1

    #    it "should be assignable", ->
    #      skinGroup.group = -1
    #      expect(skinGroup.group).toEqual -1

    #  describe "data", ->

    #    it "should be accessible", ->
    #      dataArray = new Uint8Array(
    #        buffer,
    #        Header.LENGTH + 4,
    #        header.skinSize - 4
    #      )
    #      expect(skin.data).toEqual dataArray

    #    it "should be editable", ->
    #      skin.data[0] = 5
    #      expect(skin.data[0]).toEqual 5
