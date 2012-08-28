define [
  "cs!vendor/mixin"
],

(Mixin) ->

  class Accessorize extends Mixin

    define: (prop, desc) -> Object.defineProperty this::, prop, desc
