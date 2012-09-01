define [
  "cs!lib/mdl/vector_3"
],

(Vector3) ->

  describe "Vector3", ->

    vector = null

    describe "#constructor", ->

      describe "when passed a BufferArrayView", ->

        vectorView = null

        beforeEach ->
          buffer     = new ArrayBuffer 12
          vectorView = new Float32Array buffer
          vectorView[0] = 1.1
          vectorView[1] = 2.2
          vectorView[2] = 3.3
          vector     = new Vector3(vectorView)

        it "should set the x, y, and z coordinates and the view", ->
          expect(vector.x).toBeCloseTo 1.1
          expect(vector.y).toBeCloseTo 2.2
          expect(vector.z).toBeCloseTo 3.3
          expect(vector.data).toEqual vectorView


      #TODO: Decide if this will be supported
      #describe "with 3 arguments", ->

      #  beforeEach -> vector = new Vector3(1.1, 2.2, 3.3)

      #  it "should set the x, y, and z coordinates", ->
      #    expect(vector.x).toEqual 1.1
      #    expect(vector.y).toEqual 2.2
      #    expect(vector.z).toEqual 3.3
