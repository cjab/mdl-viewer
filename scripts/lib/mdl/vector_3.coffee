define [
  "cs!lib/mixins/accessorize"
],

(Accessorize) ->

  class Vector3

    Accessorize::augment this

    @LENGTH: 12 # bytes

    constructor: (@_data) ->

    @define 'x'
      get:       -> @_data[0]
      set: (val) -> @_data[0] = val


    @define 'y'
      get:       -> @_data[1]
      set: (val) -> @_data[1] = val


    @define 'z'
      get:       -> @_data[2]
      set: (val) -> @_data[2] = val


    @define 'data'
      get:       -> @_data
      set: (val) -> @_data = val
