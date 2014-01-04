request-with-cookies
====================

[![NPM](https://nodei.co/npm/request-with-cookies.png)](https://nodei.co/npm/request-with-cookies/)

An enhancement to mikeal/request library to create reusuable clients that supports cookies per client


## Usage

Create a new client and use the same API as [mikeal/request](https://github.com/mikeal/request/)

```javascript
var request = require("request-with-cookies");
var client = request.createClient();
client("http://www.google.com", function (error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log(body) // Prints the google web page.
  }
});
```

## Implementation details

`createClient()` is a one liner that uses `request.defaults` to create an instance of `request` with a new instance of cookie jar

```javascript
module.exports.createClient = () -> request.defaults({jar: request.jar()})
```

## Build and Test

The code can be built using [gulp](http://gulpjs.com/) as follows

```
$ gulp 
```

Run tests using

```
$ npm test
```
