!SLIDE title
## Okay, enough complaining
# What can we actually do?


!SLIDE bullets
# Semver?

`"package-name": "^x.y.z"`

- change `x`: breaking change
- change `y`: new feature
- change `z`: bug fix


!SLIDE bullets

# permessage-deflate DoS
## CVE-2017-14919

- Dec 31 2016: zlib v1.2.9
- Apr 4 2017: Node.js v4.8.2, v6.10.2
- Aug 16 2017: Faye project detects issue
- Aug 18 2017: Myles Borins opens zlib#291
- Sep 10 2017: permessage-deflate patched
- Oct 24 2017: Node.js v4.8.5, v6.11.5, v8.8.0


!SLIDE title
# Never break anything


!SLIDE quote

> It’s my fault and I’m very sorry. Unfortunately it’s impossible to undo now.

<cite>Ryan Dahl, here, yesterday</cite>


!SLIDE code white

```
.
└─┬ webpack-dev-server
  └─┬ sockjs
    ├─┬ faye-websocket
    │ └─┬ websocket-driver
    │   ├── http-parser-js
    │   └── websocket-extensions
    └── uuid
```


!SLIDE code

```js
  "dependencies": {
    "http-parser-js": ">=0.4.0",
    "websocket-extensions": "*"
  }
```


!SLIDE title
# Communicate


!SLIDE code

```js
['foo', 'bar', 'qux']

// vs.

new Set(['foo', 'bar', 'qux'])
```


!SLIDE code

```js
{ foo: 1, bar: 2 }

// vs.

new Map([['foo', 1], ['bar', 2]])
```


!SLIDE code

```js
host + port

// vs.

`${host}${port}`

// or

[host, port].join('')
```


!SLIDE title
# Avoid brittle constructions


!SLIDE code

```js
function configure(a, b, c, /* ... */)

configure(true, false, 0) // ???

// vs.

function configure({ a=false, b=false, c=0 })

configure({ a: true, c: 3 })
```


!SLIDE code

```js
function get(url, callback) {
  let request = http.request(/* ... */)

  request.on('response', function(response) {
    callback(null, response)
  })
}
```


!SLIDE code

```js
function get(url, headers, callback) {
  if (typeof headers === 'function') {
    callback = headers
    headers  = {}
  }

  let request = http.request(/* ... */)

  request.on('response', (response) => {
    callback(null, response)
  })
}
```


!SLIDE code

```js
function get(url) {
  return new Promise((resolve, reject) => {
    let request = http.request(/* ... */)

    request.on('response', (response) => {
      resolve(response)
    })
  })
}
```


!SLIDE code

```js
function get(url, headers = {}) {
  return new Promise((resolve, reject) => {
    let request = http.request(/* ... */)

    request.on('response', (response) => {
      resolve(response)
    })
  })
}
```


!SLIDE title
# Errors are your friend


!SLIDE code

```js
const assert = require('assert')

function contains(list, value) {
  assert(Array.isArray(list),
    'first argument to contains() \
     must be an array')

  let items = list.filter(el => el === value)
  return items.length
}
```


!SLIDE code

```js
const crypto = require('crypto')

let bytes = (entropy || 256) / 8
crypto.pbkdf2Sync(key, msg, 1000, bytes, 'sha1')
```


!SLIDE code

```js
const crypto = require('crypto')

let bytes = (entropy || 256) / 8
crypto.pbkdf2Sync(key, msg, 1000, bytes, 'sha1')

// -> "keylen" is out of range.
//    It must be >= 0 && <= 2147483647.
//    Received 82.25
```


!SLIDE
![](digging.png)


!SLIDE code

```js
client
    ._dispatcher
        ._transport
            ._socket
                .send('lol')
```


!SLIDE title
# Documentation


!SLIDE

> To connect through a proxy, call `proxy()` on the driver object, passing in
> the proxy's URL. Pipe the TCP socket through the returned object, and when it
> emits the `connect` event, start the driver as normal.


!SLIDE code small

```js
const net = require('net'),
      websocket = require('websocket-driver')

let driver = websocket.client('ws://www.example.com/socket'),
    proxy  = driver.proxy('http://user:pass@proxy.example.com'),
    tcp    = net.connect(80, 'proxy.example.com')

tcp.pipe(proxy).pipe(tcp, { end: false })

tcp.on('connect', () => proxy.start())

proxy.on('connect', () => {
  driver.io.pipe(tcp).pipe(driver.io)
  driver.start()
})

driver.messages.on('data', (message) => {
  console.log('Got a message', message)
})
```


!SLIDE title
# Automated testing


!SLIDE code

```js
describe('contains()', () => {
  it('counts the matches in an array', () => {
    let array = ['duck', 'duck', 'goose']
    expect(contains(array, 'duck')).toEqual(2)
  })

  it('counts the matches in a set', () => {
    let set = new Set(['duck', 'duck', 'goose'])
    expect(contains(set, 'duck')).toEqual(1)
  })
})
```


!SLIDE code

```
● contains() › counts the matches in a set

  TypeError: list.filter is not a function

    1 | function contains(list, value) {
  > 2 |   let items = list.filter(el => el === value)
      |                    ^
    3 |   return items.length
    4 | }
    5 |
```


!SLIDE title
# What have we learned?


!SLIDE bullets

- Compatibility is determined by context
- Context is constructed via usage
- You can influence usage through communication


!SLIDE title
# Thank you.
## @mountain_ghosts
## `http://slides.jcoglan.com`
