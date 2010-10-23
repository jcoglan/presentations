!SLIDE frontpage
# Faye
## An Evented Server-Side App

!SLIDE bullets
# What is it?

* Simple pub/sub for the web
* Bayeux message broker and client
* For Node, Ruby, browsers

!SLIDE
# Ruby server

    @@@ ruby
    # config.ru
    
    require 'faye'
    
    server = Faye::RackAdapter.new(:mount => '/bayeux')
    run server


!SLIDE
# JavaScript client

    @@@ javascript
    // client.js
    
    var client = new Faye.Client('http://localhost:9292/bayeux');
    
    client.subscribe('/some/channel', function(message) {
      // handle message
    });
    
    client.publish('/another/channel', {hello: 'world'});


!SLIDE
# Ruby client

    @@@ ruby
    # client.rb
    
    require 'faye'
    require 'eventmachine'
    
    EM.run {
      client = Faye::Client.new('http://localhost:9292/bayeux')
      
      client.subscribe '/some/channel' do |message|
        # handle message
      end
      
      client.publish('/another/channel', 'hello' => 'world')
    }


!SLIDE
# Message passing

    @@@ javascript
    // In Ruby...
    
    ruby_client.publish('/foo', 'hello' => 'world')
    
    
    // In the browser...
    
    js_client.subscribe('/foo', function(message) {
      // message = {hello: 'world'}
      
      // alerts "world"
      alert(message.hello);
    });
