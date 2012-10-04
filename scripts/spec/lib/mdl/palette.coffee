define [
  "cs!lib/mdl/palette"
],

(Palette) ->

  describe "Palette", ->

    it "should store the quake palette", ->
      for color in Palette
        element = document.createElement "div"
        content = document.createTextNode "\u00a0"
        hex     = color.toString(16)
        (hex = "0" + hex) while hex.length < 6
        element.style.backgroundColor = "##{hex}"
        element.appendChild content
        document.body.insertBefore element
