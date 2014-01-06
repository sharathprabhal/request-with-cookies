
request = require "request"

module.exports.createClient = (options) ->
  options ?= {}
  options.jar ?= request.jar()
  request.defaults(options)