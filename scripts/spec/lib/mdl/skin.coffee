define [
  "cs!lib/mdl/skin"
  "cs!lib/mdl/header"
],

(Skin, Header) ->

  describe "Skin", ->

    buffer   = null
    header   = null
    skin     = null
    dataView = null
    modelUrl = "/data/pak0/progs/player.mdl"

    beforeEach -> buffer = @env.buffer.slice(0)

    #describe "#constructor", ->

    #  beforeEach ->
    #    header   = new Header(buffer)
    #    dataView = new DataView(buffer, Header.LENGTH, header.skinSize)
    #
       #TODO: Test this exception, this is difficult because requirejs makes it
       #      difficult to determine the context of the Skin constructor.
    #  it "should throw an exception when passed an invalid skin", ->
    #    console.log requirejs.context
    #    spyOn(context, "Skin").andCallThrough()
    #    skin = new Skin(dataView)


    describe "property", ->

      beforeEach ->
        header   = new Header(buffer)
        dataView = new DataView(buffer, Header.LENGTH, header.skinSize + 4)
        skin     = new Skin(dataView)

      describe "group", ->

        it "should be accessible", ->
          expect(skin.group).toEqual 0

        it "should be assignable", ->
          skin.group = -1
          expect(skin.group).toEqual -1

      describe "data", ->

        it "should be accessible", ->
          dataArray = new Uint8Array(
            buffer,
            Header.LENGTH + 4,
            header.skinSize
          )
          expect(skin.data).toEqual dataArray

        it "should be editable", ->
          skin.data[0] = 5
          expect(skin.data[0]).toEqual 5

      describe "size", ->

        it "should calculate the size in bytes of the skin", ->
          expect(skin.size).toEqual(header.skinSize + 4)

