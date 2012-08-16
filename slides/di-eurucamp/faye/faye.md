!SLIDE title
# Let’s talk about DI
## When should we use it?

!SLIDE
# What is DI?

    @@@ruby
    class Github::Client
      def get_user(name)
        u = URI.parse("https://api.github.com/users/#{name}")
        http = Net::HTTP.new(u.host, u.port)
        http.use_ssl = true
        response = http.request_get(u.path)
        if response.code == '200'
          JSON.parse(response.body)
        else
          raise NotFound
        end
      end
    end

!SLIDE
# What is DI?

    @@@ruby
    class Github::Client
      def initialize(http_client)
        @http = http_client
      end
      
      def get_user(name)
        data = @http.get("/users/#{name}").json_data
        Github::User.new(data)
      end
    end

!SLIDE title
# What is DI _for_?

!SLIDE title
# Wrong.
## If you said ‘testing’, you owe me a beer

!SLIDE title
# s/testable/usable/
## Testability is a side-effect of usability

!SLIDE title
# Design is about constraints
## Patterns emerge to meet program requirements

!SLIDE title
## An example:
# Faye, pubsub message bus

!SLIDE
# Messages

    @@@javascript
    // Client -> Server
    { "channel":  "/meta/handshake",
      "version":  "1.0",
      "supportedConnectionTypes": ["polling", "websocket"]
    }
    
    // Server -> Client
    { "channel":    "/meta/handshake",
      "successful": true,
      "clientId":   "cpym7ufcmkebx4nnki5loe36f",
      "version":    "1.0",
      "supportedConnectionTypes": ["polling", "websocket"]
    }

!SLIDE
# Messages

    @@@javascript
    // Client -> Server
    { "channel":      "/meta/subscribe",
      "clientId":     "cpym7ufcmkebx4nnki5loe36f",
      "subscription": "/foo"
    }
    
    // Server -> Client
    { "channel":    "/meta/subscribe",
      "clientId":   "cpym7ufcmkebx4nnki5loe36f",
      "successful": true
    }

!SLIDE

                          +--------+
                          | Client |
                          +---+----+
                              |
                              V
                          +--------+
                          | Server |
                          +--------+

!SLIDE

                          +--------+
                          | Client |
                          +---+----+
                              |
                              V
    +-----------+-------------+----------------+--------+
    | WebSocket | EventSource | XMLHttpRequest | JSON-P |
    +-----------+-------------+----------------+--------+
                              |
                              V
                          +--------+
                          | Server |
                          +--------+

!SLIDE title
# Should we use DI here?
## After all, we have multiple implementations

!SLIDE

    @@@ruby
    # Should we do this?
    
    server = Server.new(WebSocketHandler.new)

!SLIDE bullets
# Not on the server
* The server has to handle _all_ transport types
* The user does not have a choice
* There is nothing to change

!SLIDE

    @@@ruby
    # What about on the client?
    
    var uri    = 'http://www.example.com/faye',
        client = new Client(new WebSocketClient(uri))

!SLIDE bullets
# Not in _this_ case
* Transport dictated by what server supports
* May not work depending on browser
* May improve testability

!SLIDE title
# Let’s look at the server
## We have more choice here

!SLIDE

    +--------------+
    |  RackServer  |    --> * WebSocket, HTTP POST, JSON-P
    +-------+------+
            |                           |   message
            V                           V   objects
    +---------------+
    | BayeuxHandler |   --> * Bayeux message protocol
    +---------------+       * Connections / subscriptions
                            * Message queues

!SLIDE

    +--------------+
    |  RackServer  |    --> * WebSocket, HTTP POST, JSON-P
    +-------+------+
            |                           |   message
            V                           V   objects
    +---------------+
    | BayeuxHandler |   --> * Bayeux message protocol
    +---------------+     +-------------------------------+
                          | * Connections / subscriptions |
                          | * Message queues              |
                          +-------------------------------+
                                        STATE

!SLIDE

    +--------------+
    |  RackServer  |    --> * WebSocket, HTTP POST, JSON-P
    +-------+------+
            |                           |   message
            V                           V   objects
    +---------------+
    | BayeuxHandler |   --> * Bayeux message protocol
    +---------------+
            |
            V
    +--------------+
    |    Engine    |    --> * Subscriptions
    +--------------+        * Message queues

!SLIDE

                      +--------------+
                      |  RackServer  |
                      +-------+------+
                              |
                              V
                      +---------------+
                      | BayeuxHandler |
                      +---------------+
                              |
                    +---------+---------+
                    |                   |
            +--------------+     +-------------+
            | MemoryEngine |     | RedisEngine |
            +--------------+     +-------------+

!SLIDE bullets
# Here we use DI
* Multiple swappable implementations
* User has complete control
* No environmental dictation

!SLIDE

    @@@ruby
    class RackServer
      def initialize(engine)
        @handler = BayeuxHandler.new(engine)
      end
      
      def call(env)
        request  = Rack::Request.new(env)
        message  = JSON.parse(request.params[:message])
        response = @handler.process(message)
        [
          200,
          {'Content-Type' => 'application/json'},
          [JSON.dump(response)]
        ]
      end
    end

!SLIDE

    @@@ruby
    server = RackServer.new(RedisEngine.new)
    
    thin = Rack::Handler.get('thin')
    thin.run(server, :Port => 80)

!SLIDE title
# Testability as a bonus
## Good tests are a by-product of good design

!SLIDE

    @@@ruby
    describe RackServer do
      include Rack::Test::Methods
      let(:engine) { mock 'engine' }
      let(:app)    { RackServer.new(engine) }
      
      describe 'handshake' do
        let(:message) {{
          'channel' => '/meta/handshake',
          'version' => '1.0',
          'supportedConnectionTypes' => ['long-polling']
        }}
        
        it 'creates a new client session' do
          engine.should_receive(:create_client).and_return 'new_client_id'
          post '/bayeux', :message => JSON.dump(message)
        end
      end
    end
