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
        clientA.subscribe('/foo', function(message) {
          this.message = message;
        }, this);
        setTimeout(function() {
          clientB.publish('/foo', {hello: 'world'});
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
      client( 'A', ['/foo'] )
      client( 'B', [] )
      publish( 'B', '/foo', {hello: 'world'} )
      checkInbox( 'A', [{hello: 'world'}] )
      checkInbox( 'B', [] )
    }})


!SLIDE callout
# Yeah, but--
## I know. It's going to be okay.


!SLIDE
## Implement the test actions with callbacks

    @@@ javascript
    Scenario = function() {
      this._clients = {};
      this._inboxes = {};
    };
    
    Scenario.prototype.
        server = function(port, resume) {
          this._port = port;
          var server = new Faye.NodeAdapter({mount: '/'});
          server.listen(port);
          setTimeout(resume, 500);
        };


!SLIDE
## Implement the test actions with callbacks

    @@@ javascript
    Scenario.prototype.
        client = function(name, channels, resume) {
          var endpoint = 'http://0.0.0.0:' + this._port,
              client   = new Faye.Client(endpoint);
          
          channels.forEach(function(channel) {
            client.subscribe(channel, function(message) {
              this._inboxes[name].push(message);
            }, this);
          }, this);
          
          this._clients[name] = client;
          this._inboxes[name] = [];
          setTimeout(resume, 100);
        };


!SLIDE
## The test runner queues up commands

    @@@ javascript
    CommandQueue = function() {
      this._scenario = new Scenario();
      this._commands = [];
    };
    
    CommandQueue.prototype = {
      server: function(port) {
        this.enqueue(['server', port]);
      },
      client: function(name, channels) {
        this.enqueue(['client', name, channels]);
      },
      publish: function(name, channel, message) {
        this.enqueue(['publish', name, channel, message]);
      },
      checkInbox: function(name, messages) {
        this.enqueue(['checkInbox', name, messages]);
      }
    };


!SLIDE
## The first command triggers the test run

    @@@ javascript
    CommandQueue.prototype.
        enqueue = function(command) {
          this._commands.push(command);
          if (this._started) return;
          
          this._started = true;
          
          var self = this;
          setTimeout(function() { self.runNext() }, 100);
        };


!SLIDE
## Run each command passing a callback to run the next

    @@@ javascript
    CommandQueue.prototype.
        runNext = function() {
          var command = this._commands.shift().slice(),
              method  = command.shift(),
              self    = this;

          var resume = function() { self.runNext() };
          command.push(resume);

          this._scenario[method].apply(this._scenario,
                                       command);
        };


!SLIDE
## Glue the whole thing together

    @@@ javascript
    Scenario.run = function(testName, block) {
      var queue = new CommandQueue();
      block.call(queue);
    };

