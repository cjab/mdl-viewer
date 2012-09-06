define [
  "cs!lib/mdl/triangle"
  "cs!lib/mdl/header"
  "cs!lib/mdl/model"
],

(Triangle, Header, Model) ->

  describe "Triangle", ->

    buffer   = null
    model    = null
    dataView = null
    offset   = null
    modelUrl = "/data/pak0/progs/player.mdl"
    triangle = null

    beforeEach ->
      xhr = new XMLHttpRequest()
      xhr.responseType = "arraybuffer"
      xhr.open "GET", modelUrl
      xhr.onload = (e) -> buffer = xhr.response
      xhr.send()
      waitsFor -> xhr.readyState == 4


    describe "property", ->

      beforeEach ->
        model = new Model(buffer)
        #TODO: Calculate proper offset
        offset   = model.triangleOffset
        dataView = new DataView(buffer, offset, Triangle.LENGTH)
        triangle = new Triangle(dataView)

      describe "facesFront", ->

        it "should be accessible", ->
          expected = dataView.getUint32(0, Header.IS_LITTLE_ENDIAN)
          expect(triangle.facesFront).toEqual expected

        it "should be assignable", ->
          triangle.facesFront = 3
          expect(triangle.facesFront).toEqual 3


      describe "vertices", ->

        it "should be accessible", ->
          expected = new Int32Array(buffer, offset + 4, 3)
          expect(triangle.vertex[0]).toEqual expected[0]
          expect(triangle.vertex[1]).toEqual expected[1]
          expect(triangle.vertex[2]).toEqual expected[2]

        it "should be assignable", ->
          triangle.vertex[0] = 3
          triangle.vertex[1] = 4
          triangle.vertex[2] = 5
          expect(triangle.vertex[0]).toEqual 3
          expect(triangle.vertex[1]).toEqual 4
          expect(triangle.vertex[2]).toEqual 5
