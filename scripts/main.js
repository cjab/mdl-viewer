require.config({
  paths: {
    jQuery:       "vendor/jquery/jquery",
    Underscore:   "vendor/underscore/underscore",
    Backbone:     "vendor/backbone/backbone",
    CoffeeScript: "vendor/coffeescript/coffeescript",
    bootstrap:    "vendor/bootstrap/bootstrap",
    keyboard:     "vendor/keyboard/keyboard",
    cs:           "vendor/require/cs",
    text:         "vendor/require/text",
    order:        "vendor/require/order",
    templates:    "../templates",
    data:         "../data"
  }
});

define([
  "cs!app",
  "order!vendor/jquery/jquery-min",
  "order!vendor/underscore/underscore-min",
  "order!vendor/backbone/backbone-min",
  "order!vendor/bootstrap/bootstrap-min"
], function(App) {
  App.initialize();
});
