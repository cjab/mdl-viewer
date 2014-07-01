({
  appDir:  "../",
  baseUrl: "scripts",
  dir:     "../build",
  paths: {
    jQuery:       "vendor/jquery/jquery",
    Underscore:   "vendor/underscore/underscore",
    Backbone:     "vendor/backbone/backbone",
    CoffeeScript: "vendor/coffeescript/coffeescript",
    Three:        "vendor/three/three",
    bootstrap:    "vendor/bootstrap/bootstrap",
    keyboard:     "vendor/keyboard/keyboard",
    text:         "vendor/require/text",
    order:        "vendor/require/order",
    templates:    "../templates",
    data:         "../data",
    cs:           "vendor/require/csBuild",
    csBuild:      "vendor/require/cs"
  },
  modules: [
    {
      name: "main",
      exclude: ["CoffeeScript"]
    }
  ]
})
