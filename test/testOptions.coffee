request = require "../lib/"
app = require "./testServer"
should = require "should"
assert = require "assert"

server = {}
port = 3001
url = "http://localhost:" + port

describe "Options", () ->

  before (done) ->
    server = app.listen(port)
    done()

  after (done) ->
    server.close()
    done()

  it "should be able to bake in default options", (done) ->
    options =
      qs:
        defaultKey: "someValue"

    client = request.createClient(options)
    client (url + "/checkDefaultQueryString"), (err, res, body) ->
      if err
        throw err
      body.should.equal("qs present")

      # Send another request
      client (url + "/checkDefaultQueryString"), (err, res, body) ->
        if err
          throw err
        body.should.equal("qs present")
        done()

  it "should be able to override cookies option", (done) ->
    options = 
      jar: false

    client = request.createClient(options)
    client (url + "/login?username=foo"), (err, res, body) ->
      if err
        throw err
      body.should.equal("loggedIn")
      client (url + "/secure"), (err, res, body) ->
        if err
          throw err
        body.should.equal("Forbidden")
        done()




