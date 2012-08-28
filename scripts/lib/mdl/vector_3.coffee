define [
],

() ->

  class Vector3

    @LENGTH: 12 # bytes

    constructor: (@data) ->

    x: -> @data[0]


    y: -> @data[1]


    z: -> @data[2]
