request-with-cookies
====================

[![NPM](https://nodei.co/npm/request-with-cookies.png)](https://nodei.co/npm/request-with-cookies/)

[![Build Status](https://travis-ci.org/sharathprabhal/request-with-cookies.png?branch=master)](https://travis-ci.org/sharathprabhal/request-with-cookies)

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

You can also create a client with baked in options
```javascript
var request = require("request-with-cookies");
var options = {
  qs: {
    q: "foo"
  }
};

var client = request.createClient(options);
// now every request will be sent with "?q=foo" appended to the URL
client("http://www.google.com", function (error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log(body) // Prints the google web page.
  }
});
```

Custom cookies can be set by passing in the following options
```javascript
var options = {
  url: "https://foobar.com",
  cookies: [
  	{
  	  name: "foo",
  	  value: "v1"
  	},
  	{
  	  name: "bar",
  	  value: "v2"
  	}
  ]
};
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
