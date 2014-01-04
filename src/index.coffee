
request = require "request"

module.exports.createClient = () -> request.defaults({jar: request.jar()})