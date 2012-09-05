define [
  "cs!lib/mixins/accessorize"
  "cs!lib/mdl/header"
],

(Accessorize, Header) ->

  class Triangle

    Accessorize::augment this


    @LENGTH = 16 # bytes
