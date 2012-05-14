!SLIDE frontpage
# Faye
## An Evented Server-Side App

!SLIDE bullets
# What is it?

* Simple pub/sub for the web
* Bayeux message broker and client
* For Node, Ruby, browsers

!SLIDE
# How do I use it?

    @@@javascript
    // server.js ================
    
    var Faye = require('faye');
    
    var server = new Faye.NodeAdapter({mount: '/'});
    server.listen(8000);
    
    
    // client.js ================
    
    var client = new Faye.Client('http://127.0.0.1:8000');
    
    client.subscribe('/some/channel', function(message) {
      // handle message
    });
    
    client.publish('/another/channel', {hello: 'world'});
