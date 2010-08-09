!SLIDE callout
# Testing
## Everyone loves async tests, right?


!SLIDE
# Um.

    @@@ javascript
    AsyncSpec = JS.Test.describe(Faye.Client, function() {
      before(function(resume) {
        var server = new Faye.NodeAdapter({mount: '/'});
        server.listen(8000);
        setTimeout(resume, 500);
      })
      
      it('sends a message from A to B', function(resume) {
        clientA.subscribe('/channel', function(message) {
          this.message = message;
        }, this);
        setTimeout(function() {
          clientB.publish('/channel', {hello: 'world'});
          setTimeout(function() {
            resume(function() {
              assert.deepEqual({hello: 'world'}, message);
            })
          }, 250);
        }, 100);
      })
    })


!SLIDE commandline incremental
    $ node ./specs/client_spec.js
    F
    
    1) Failure: Faye.Client sends a message from A to B
       <readable spec> expected
       but got <WTF???>
    
    1 test, 1 assertion, 1 failure, 0 errors
    

!SLIDE
# Tests MUST be readable

    @@@ javascript
    Scenario.run('Two clients, single message sent',
    function() { with(this) {
      server( 8000 )
      client( 'A', ['/channel'] )
      client( 'B', [] )
      publish( 'B', '/channel', {hello: 'world'} )
      checkInbox( 'A', [{hello: 'world'}] )
      checkInbox( 'B', [] )
    }})


!SLIDE callout
# Yeah, but--
## I know. It's going to be okay.


!SLIDE
## Implement the test actions with callbacks

    @@@ javascript
    AsyncScenario = function() {
      this._clients = {};
      this._inboxes = {};
    };
    
    AsyncScenario.prototype.
        server = function(port, resume) {
          this._port = port;
          var server = new Faye.NodeAdapter({mount: '/'});
          server.listen(port);
          setTimeout(resume, 500);
        };


!SLIDE
## Implement the test actions with callbacks

    @@@ javascript
    AsyncScenario.prototype.
        client = function(name, channels, resume) {
          var endpoint = 'http://0.0.0.0:' + this._port,
              client   = new Faye.Client(endpoint);
          
          channels.forEach(function(channel) {
            client.subscribe(channel, function(message) {
              this._inboxes[name].push(message);
            }, this);
          }, this);
          
          this._clients[name] = client;
          setTimeout(resume, 100);
        };


!SLIDE
## The test runner queues up commands

    @@@ javascript
    TestRunner = function() {
      this._scenario = new AsyncScenario();
      this._queue = [];
    };
    
    TestRunner.prototype = {
      server: function(port) {
        this._queue.push(['server', port]);
      },
      client: function(name, channels) {
        this._queue.push(['client', name, channels]);
      },
      publish: function(name, channel, message) {
        this._queue.push(['publish', name, channel, message]);
      },
      checkInbox: function(name, messages) {
        this._queue.push(['checkInbox', name, messages]);
      }
    };


!SLIDE
## Run each command passing a callback to run the next

    @@@ javascript
    TestRunner.prototype.
        runNext = function() {
          var args   = this._queue.shift().slice(),
              method = args.shift();
          
          var self = this, callback = function() {
            self.runNext();
          };
          
          args.push(callback);
          this._scenario[method].apply(this._scenario, args);
        };

