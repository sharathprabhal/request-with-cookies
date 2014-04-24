
request = require "request"
async = require "async"

module.exports.createClient = (options) ->
  options ?= {}
  options.jar ?= request.jar()
  if options.cookies
    async.reduce options.cookies, options.jar, (result, cookie, cb) ->
      cookieStr = cookie.name + "=" + cookie.value
      options.jar.setCookie cookieStr, options.url, (err, c) ->
        if (err)
          cb err
        else
          cb null, options.jar
    , (err, result) ->
      options.jar = result

  request.defaults(options)