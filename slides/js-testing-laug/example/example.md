!SLIDE callout
# Example:
## Cross-platform Twitter client


!SLIDE commandline

    $ curl 'http://search.twitter.com/search.json?q=@jcoglan'

    {
        "results": [{
            "id": 23843942428577792,
            "created_at": "Sat, 08 Jan 2011 20:50:13 +0000",
            "from_user_id": 4393058,
            "from_user": "extralogical",
            "to_user_id": 86308,
            "to_user": "jcoglan",
            "text": "@jcoglan I need to write some JS testing code...",
        }
        ...
        ]
    }


!SLIDE
# JavaScript API

```javascript
var client = new Twitter()

client.search('@jcoglan', function(tweets) {
  // tweets == [{to_user: 'jcoglan', ...}, ...]
})
```

!SLIDE
# Project layout

    twitter/
        source/
            twitter.js            : source code
        test/
            browser.html          : runs in browsers
            console.js            : runs on command line
            run.js                : loads and runs all tests
            specs/
                twitter_spec.js   : test definitions
        vendor/
            jsclass/
                core.js           |
                loader.js         | -> Framework code
                test.js           |
                (etc)             |


!SLIDE
# test/console.js

```javascript
JSCLASS_PATH = 'vendor/jsclass';
require('../' + JSCLASS_PATH + '/loader')
require('./run')
```

!SLIDE
# test/run.js

```javascript
JS.Packages(function() { with(this) {
  autoload(/^(.*)Spec$/, {
           from: 'test/specs',
           require: '$1' })

  file('source/twitter.js')
    .provides('Twitter')
    .requires('JS.Class')
}})

JS.require('JS.Test', function() {
  JS.require('TwitterSpec',
             function() { JS.Test.autorun() })
})
```

!SLIDE
# test/specs/twitter_spec.js

```javascript
TwitterSpec = JS.Test.describe("Twitter", function() {
  before(function() {
    this.client = new Twitter()
  })

  it("yields matching tweets", function(resume) {
    client.search("@jcoglan", function(tweets) {
      resume(function() {
        assertEqual( "jcoglan", tweets[0].to_user )
      })
    })
  })
})
```

!SLIDE commandline

    $ node test/console.js

    Error: Cannot find module './source/twitter'


!SLIDE commandline

    $ mkdir source
    $ touch source/twitter.js
    $ node test/console.js

    Error: Expected package at ./source/twitter.js
           to define Twitter


!SLIDE
# source/twitter.js

```javascript
Twitter = new JS.Class('Twitter')
```

!SLIDE commandline

    $ node test/console.js

    Loaded suite Twitter
    Started
    E
    Finished in 0.072 seconds.

    1) Error:
    test: Twitter returns tweets matching the search:
    TypeError: Object #<Twitter> has no method 'search'

    1 tests, 0 assertions, 0 failures, 1 errors


!SLIDE
# source/twitter.js

```javascript
Twitter = new JS.Class('Twitter', {
  search: function(query, callback) {
    var http   = require('http'),
        host   = 'search.twitter.com',
        client = http.createClient(80, host)

    var request = client.request('GET',
                  '/search.json?q=' + query,
                  {host: host})

    request.addListener('response', function(response) {
      response.addListener('data', function(data) {
        var tweets = JSON.parse(data).results
        callback(tweets)
      })
    })
    request.end()
  }
})
```

!SLIDE commandline

    $ node test/console.js

    Loaded suite Twitter
    Started
    .
    Finished in 2.684 seconds.

    1 tests, 1 assertions, 0 failures, 0 errors


!SLIDE
# test/browser.html

```html
<!doctype html>
<html>
  <head>
    <meta http-equiv="Content-type" content="text/html">
    <title>Twitter test suite</title>
  </head>
  <body>
    <script src="../vendor/jsclass/loader.js"></script>
    <script src="../test/run.js"></script>
  </body>
</html>
```

!SLIDE center
# Browser results
![Test results](fails.png)


!SLIDE
# source/twitter.js

```javascript
Twitter = new JS.Class('Twitter', {
  search: function(query, callback) {
    if (typeof document === 'object')
      this.jsonpSearch(query, callback)
    else
      this.nodeSearch(query, callback)
  },

  // ...
```

!SLIDE
# source/twitter.js

```javascript
  // (cont.)

  jsonpSearch: function(query, callback) {
    var script  = document.createElement('script')
    script.type = 'text/javascript'
    script.src  = 'http://search.twitter.com/search.json?' +
                  'callback=__twitterCB__&' +
                  'q=' + query

    window.__twitterCB__ = function(tweets) {
      window.__twitterCB__ = undefined
      callback(tweets.results)
    }
    var head = document.getElementsByTagName('head')[0]
    head.appendChild(script)
  },

  nodeSearch: function(query, callback) {
    // ...
  }
})
```

!SLIDE center
# Browser results
![Test results](passes.png)


!SLIDE
# source/twitter.js

```javascript
Twitter = new JS.Class('Twitter', {
  search: function(query, callback) {
    var resource = 'http://search.twitter.com' +
                   '/search.json?q=' + query

    Twitter.Net.getJSON(resource, callback)
  }
})
```

!SLIDE
# test/specs/twitter_spec.js

```javascript
TwitterSpec = JS.Test.describe("Twitter", function() {
  before(function() {
    this.client = new Twitter()

    stub(Twitter.Net, "getJSON")
        .given("http://search.twitter.com/...")
        .yields([{to_user: "jcoglan"}])
  })

  it("yields matching tweets", function() {
    // ...
  })
})
```