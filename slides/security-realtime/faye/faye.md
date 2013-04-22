!SLIDE bullets
# What is Faye?

* Simple pub/sub messaging for the web
* Servers and clients for Ruby and Node
* Bayeux protocol over WebSocket and HTTP


!SLIDE

    @@@javascript
    var Faye = require('faye');

    var server = new Faye.NodeAdapter({
      mount:   '/faye',
      timeout: 60
    });
    server.listen(8000);


!SLIDE

    @@@javascript
    var url    = 'http://localhost:8000/faye',
        client = new Faye.Client(url);

    client.subscribe('/messages', function(msg) {
      alert('Got a message: ' + msg.text);
    });


!SLIDE

    @@@javascript
    client.publish('/messages', {
      text: 'Hello, world!'
    });


!SLIDE title
# Bayeux protocol
## Over WebSocket, EventSource, HTTP


!SLIDE

    @@@javascript
    // client -> server

    {
      "channel": "/meta/handshake",
      "version": "1.0",
      "supportedConnectionTypes": [
        "websocket", "long-polling"
      ]
    }


!SLIDE

    @@@javascript
    // server -> client

    {
      "channel":    "/meta/handshake",
      "successful": true,
      "clientId":   "79o6pn01muyqn1t5gkte0zy",
      "version":    "1.0",
      "supportedConnectionTypes": [
        "websocket", "long-polling"
      ]
    }


!SLIDE

    @@@javascript
    // client -> server

    {
      "channel":      "/meta/subscribe",
      "clientId":     "79o6pn01muyqn1t5gkte0zy",
      "subscription": "/messages"
    }


!SLIDE

    @@@javascript
    // server -> client

    {
      "channel":      "/meta/subscribe",
      "clientId":     "79o6pn01muyqn1t5gkte0zy",
      "subscription": "/messages",
      "successful":   true
    }


!SLIDE

    @@@javascript
    // client -> server

    {
      "channel":  "/meta/connect",
      "clientId": "79o6pn01muyqn1t5gkte0zy"
    }


!SLIDE

    @@@javascript
    // client -> server
    // server -> client

    {
      "channel": "/messages",
      "data": {
        "text": "Hello, world!"
      }
    }


!SLIDES title
# Transport types
## How are these messages transferred?


!SLIDE bullets
# WebSocket

* Bidirectional asynchronous messaging
* Initiated via HTTP `GET` with `Upgrade: websocket`
* Browsers allow connection to any origin
* Server may check the `Origin` header


!SLIDE bullets
# EventSource

* Server-to-client push messaging
* Initiated by `GET` with `Accept: text/event-stream`
* Browsers only allow same-origin connections


!SLIDE bullets
# XMLHttpRequest

* HTTP request-response semantics
* `POST` request with `Content-Type: application/json`
* Cannot set certain headers, e.g. `Cookie`, `Origin`
* Browsers only allow same-origin by default


!SLIDE bullets
# CORS

* HTTP request-response semantics
* Browser sends pre-flight `OPTIONS` request with `Origin`
* Server grants access with `Access-Control-Allow-Origin`
* IE’s `XDomainRequest` only allows same-scheme


!SLIDE bullets
# JSON-P

* Can only make `GET` requests
* Works by injecting `script` elements
* Server returns JavaScript
* (i.e. it executes code from the target server!)
* No origin restrictions

