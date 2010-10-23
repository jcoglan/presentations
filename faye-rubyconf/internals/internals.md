!SLIDE callout
# That’s nice
## But how does it work?


!SLIDE center
# Architecture

![Faye architecture](faye-arch.png)


!SLIDE
# RackAdapter

    @@@ ruby
    class Faye::RackAdapter
      def initialize(options = {})
        @options = options
        @server  = Server.new
      end
      
      def listen(port)
        handler = Rack::Handler.get('thin')
        handler.run(self, :Port => port)
      end
    end


!SLIDE
# RackAdapter

    @@@ ruby
    # Incoming request:
    # GET /?message={...}&jsonp=blah
    
    class Faye::RackAdapter
      def call(env)
        request  = Rack::Reqest.new(env)
        message  = JSON.parse(request.params['message'])
        callback = request.params['jsonp']
        response = AsyncResponse.new
        
        @server.process(message) do |reply|
          body = "#{ callback }(#{ JSON.unparse(reply) });"
          response.succeed(body)
        end
        
        [-1, {}, []]
      end
    end


!SLIDE
# Server

    @@@ ruby
    class Faye::Server
      def initialize
        @channels    = Channel::Tree.new
        @connections = {}
      end
    end


!SLIDE
# Server

    @@@ ruby
    # message = { 'channel'  => '/some/channel',
    #             'clientId' => 'p780cnvop2',
    #             'data'     => {'hello' => 'world'}
    #           }
    
    class Faye::Server
      def process(message, &callback)
        case message['channel']
          when '/meta/subscribe'
            add_subscription(message, &callback)
          when '/meta/connect'
            accept_connection(message, &callback)
          else
            distribute_message(message, &callback)
        end
      end
    end


!SLIDE
# Server

    @@@ ruby
    class Faye::Server
      def accept_connection(message, &callback)
        client_id  = message['clientId']
        connection = get_connection(client_id)
        
        connection.callback(&callback)
      end
      
      def get_connection(client_id)
        @connections[client_id] ||= Connection.new(client_id)
      end
    end


!SLIDE
# Server

    @@@ ruby
    class Faye::Server
      def distribute_message(message, &callback)
        channel_name = message['channel']
        channels = @channels.glob(channel_name)
        
        channels.each do |channel|
          channel << message
        end
      end
    end


!SLIDE
# Channel

    @@@ ruby
    class Faye::Channel
      include Publisher
      
      def initialize(name)
        @name = name
      end
      
      def <<(message)
        publish(:receive, message)
      end
    end


!SLIDE
# Connection

    @@@ ruby
    class Faye::Connection
      include Deferrable
      
      def initialize(client_id)
        @client_id = client_id
        @channels  = Set.new
      end
      
      def subscribe(channel)
        return unless @channels.add?(channel)
        channel.add_listener(:receive) do |message|
          succeed(message)
          defer()
        end
      end
    end

