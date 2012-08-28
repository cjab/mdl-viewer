define [
],

() ->

  # Swappable Mixins in CoffeeScript
  # ================================

  # Many thanks to Hashmal, who wrote this to start.
  # https://gist.github.com/803816/aceed8fc57188c3a19ce2eccdb25acb64f2be94e

  # Usage
  # -----

  # class Derp extends Mixin
  #  setup: ->
  #    @googly = "eyes"

  #  derp: ->
  #    alert "Herp derp! What's with your #{ @googly }?"

  # class Herp
  #  constructor: ->
  #    Derp::augment this

  # herp = new Herp
  # herp.derp()

  # Mixin
  # -----

  # Classes inheriting `Mixin` will become removable mixins, enabling you to
  # swap them around.

  class Mixin

    # "Class method". Augment object or class `t` with new methods.
    augment: (t) ->
      (t[n] = m unless n == 'augment' or !this[n].prototype?) for n, m of this
      t.setup()

    # When an object is augmented with at least one mixin, call this method to
    # remove `mixin`.
    eject: (mixin) ->
      (delete this[n] if m in (p for o, p of mixin::)) for n, m of this

    # Implement in your mixin to act as a constructor for mixed-in properties
    setup: ->

  # Limitations
  # -----------

  # * When a class is augmented, all instances of that class are augmented too,
  #   and when a mixin is ejected from a class, all instances lose that mixin
  #   too.
  # * You can't eject a mixin from an object if that mixin was added to the
  #   object's class. Eject the mixin from the class instead.
