!SLIDE
# A Brief History of WebSockets
### James Coglan
### author of Faye


!SLIDE
# WebSocket API

    @@@ javascript
    var ws = new WebSocket('ws://www.example.com/demo');
    
    ws.onopen = function() {
      ws.send('Hello, World!');
    };
    
    ws.onmessage = function(event) {
      console.log(event.data);
    };
    
    ws.onclose = function(event) {
      console.log('close', event.code, event.reason);
    };


!SLIDE bullets

# January 2009

* First protocol draft published
* Known as hixie-00
* Never shipped to users


!SLIDE bullets
# February 2010

* hixie-75 published
* Shipped in Chrome 4 and Safari 5.0
* No current browser uses it


!SLIDE
# hixie-75 handshake

    GET /demo HTTP/1.1
    Upgrade: WebSocket
    Connection: Upgrade
    Host: example.com
    Origin: http://example.com
    WebSocket-Protocol: sample


!SLIDE
# hixie-75 response

    HTTP/1.1 101 Web Socket Protocol Handshake
    Upgrade: WebSocket
    Connection: Upgrade
    WebSocket-Origin: http://example.com
    WebSocket-Location: ws://example.com/demo
    WebSocket-Protocol: sample


!SLIDE
# hixie-75 framing

    0x00 $OCTET* 0xFF

Data between 0x00 and 0xFF interpreted as UTF-8


!SLIDE
# May 2010

* hixie-76 draft published
* Shipped in Firefox 4, Chrome 6, Safari 5.0.1, Opera 11.00
* New handshake, explicit closing frames


!SLIDE
# hixie-76 handshake

    GET /demo HTTP/1.1
    Host: example.com
    Connection: Upgrade
    Sec-WebSocket-Key2: 12998 5 Y3 1  .P00
    Sec-WebSocket-Protocol: sample
    Upgrade: WebSocket
    Sec-WebSocket-Key1: 4 @1  46546xW%0l 1 5
    Origin: http://example.com
    
    ^n:ds[4U


!SLIDE
# hixie-76 response

    HTTP/1.1 101 WebSocket Protocol Handshake
    Upgrade: WebSocket
    Connection: Upgrade
    Sec-WebSocket-Origin: http://example.com
    Sec-WebSocket-Location: ws://example.com/demo
    Sec-WebSocket-Protocol: sample
    
    8jKS'y:G*Co,Wxa-


!SLIDE
# hixie-76 thru a proxy

    GET /demo HTTP/1.1
    Host: example.com
    Connection: Upgrade
    Sec-WebSocket-Key2: 12998 5 Y3 1  .P00
    Sec-WebSocket-Protocol: sample
    Upgrade: WebSocket
    Sec-WebSocket-Key1: 4 @1  46546xW%0l 1 5
    Origin: http://example.com
    
    ----------------------------------------
    ^n:ds[4U


!SLIDE bullets
# April 2011

* hybi-07 draft published
* Shipped in Firefox 6
* Later hybi-10 in Firefox 7, Chrome 14
* RFC 6455 in Firefox 11, Chrome 16


!SLIDE
# hybi-07+ handshake

    GET /chat HTTP/1.1
    Host: server.example.com
    Upgrade: websocket
    Connection: Upgrade
    Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==
    Sec-WebSocket-Origin: http://example.com
    Sec-WebSocket-Protocol: chat, superchat
    Sec-WebSocket-Version: 7


!SLIDE
# hybi-07+ response

    HTTP/1.1 101 Switching Protocols
    Upgrade: websocket
    Connection: Upgrade
    Sec-WebSocket-Accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=
    Sec-WebSocket-Protocol: chat


!SLIDE reduce

    0                   1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
    +-+-+-+-+-------+-+-------------+-------------------------------+
    |F|R|R|R| opcode|M| Payload len |    Extended payload length    |
    |I|S|S|S|  (4)  |A|     (7)     |             (16/63)           |
    |N|V|V|V|       |S|             |   (if payload len==126/127)   |
    | |1|2|3|       |K|             |                               |
    +-+-+-+-+-------+-+-------------+ - - - - - - - - - - - - - - - +
    |     Extended payload length continued, if payload len == 127  |
    + - - - - - - - - - - - - - - - +-------------------------------+
    |                               |Masking-key, if MASK set to 1  |
    +-------------------------------+-------------------------------+
    | Masking-key (continued)       |          Payload Data         |
    +-------------------------------- - - - - - - - - - - - - - - - +
    :                     Payload Data continued ...                :
    + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
    |                     Payload Data continued ...                |
    +---------------------------------------------------------------+


!SLIDE bullets
# hybi-07+ features

* Length-headers rather than 0x00/0xFF
* Binary data messages
* Ping, pong, close
* Masking
* Message fragmentation


!SLIDE
# em-websocket

    @@@ ruby
    options = {:host => "0.0.0.0", :port => 8080}
    
    EventMachine::WebSocket.start(options) do |ws|
      ws.onopen    { ws.send "Hello Client!"}
      ws.onmessage { |msg| ws.send "Pong: #{msg}" }
      ws.onclose   { puts "WebSocket closed" }
      ws.onerror   { |e| puts "Error: #{e.message}" }
    end


!SLIDE
# faye-websocket

    @@@ ruby
    App = lambda do |env|
      if Faye::WebSocket.websocket?(env)
        ws = Faye::WebSocket.new(env)
        
        ws.onmessage = lambda do |event|
          ws.send(event.data)
        end
        
        ws.onclose = lambda do |event|
          p [:close, event.code, event.reason]
        end
      else
        # Normal HTTP request
      end
    end


!SLIDE
# faye-websocket

    @@@ ruby
    url = 'ws://example.com/demo'
    ws  = Faye::WebSocket::Client.new(url)
    
    ws.onopen = lambda do |event|
      p [:open, ws.protocol]
    end
    
    ws.onmessage = lambda do |event|
      ws.send(event.data)
    end
    
    ws.onclose = lambda do |event|
      p [:close, event.code, event.reason]
    end


!SLIDE bullets
# Tons of other options

* skinny, socky, websocket-rack, rocket...
* SockJS, Socket.IO
* Faye, Cramp, Goliath
* Pusher, PubNub

