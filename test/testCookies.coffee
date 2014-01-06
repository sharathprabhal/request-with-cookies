request = require "../lib/"
app = require "./testServer"
should = require "should"
assert = require "assert"

server = {}
port = 3001
url = "http://localhost:" + port

describe "Cookies", () ->

  before (done) ->
    server = app.listen(port)
    done()

  after (done) ->
    server.close()
    done()

  it "should not be able to access secure", () ->
    client = request.createClient()
    client (url + "/secure"), (err, res, body) ->
      if err
        throw err
      body.should.equal("Forbidden")

  it "should be able to access secure after login with same client", (done) ->
    client = request.createClient()
    client (url + "/login?username=foo"), (err, res, body) ->
      if err
        throw err
      body.should.equal("loggedIn")
      client (url + "/secure"), (err, res, body) ->
        if err
          throw err
        body.should.equal("foo")
        done()

  it "should not be able to secure access when " + # coffee-lint!!
  "logged in from diff clients", (done) ->
    client = request.createClient()
    client (url + "/login?username=foo"), (err, res, body) ->
      if err
        throw err
      body.should.equal("loggedIn")
      client2 = request.createClient()
      client2 (url + "/secure"), (err, res, body) ->
        if err
          throw err
        body.should.equal("Forbidden")
        done()

  it "should be able to use multiple clients", (done) ->
    client1 = request.createClient()
    client1 (url + "/login?username=user1"), (err, res, body) ->
      if err
        throw err
      body.should.equal("loggedIn")
      client1 (url + "/secure"), (err, res, body) ->
        if err
          throw err
        body.should.equal("user1")
        client2 = request.createClient()
        client2 (url + "/login?username=user2"), (err, res, body) ->
          if err
            throw err
          body.should.equal("loggedIn")
          client2 (url + "/secure"), (err, res, body) ->
            if err
              throw err
            body.should.equal("user2")
            done()
