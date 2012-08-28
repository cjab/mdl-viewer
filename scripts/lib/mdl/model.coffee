define [
  "cs!lib/mdl/header"
],

(Header) ->

  class Model

    constructor: (buffer) ->
      @header = new Header(buffer)
