# An express server for testing
express = require "express"
app = express()

app.use(express.cookieParser())
app.use(express.session({"secret": "superSecret", maxAge: 60*10000 }))

app.get "/login", (req, res) ->
  # This route mimics a login where the server drops a cookie
  res.cookie "username", req.param("username")
  res.send 200, "loggedIn"

app.get "/secure", (req, res) ->
  # This route will return the username, only if user is loggged in
  if req.cookies.username
    res.send 200, req.cookies.username
  else
    res.send 403

app.get "/checkDefaultQueryString", (req, res) ->
  if (req.param("defaultKey"))
    res.send 200, "qs present"
  else
    res.send 500

module.exports = app