!SLIDE callout
# Testing
## Everyone loves async tests, right?


!SLIDE
# So, erm.

    @@@ ruby
    describe Faye::Client do
      before do
        @clients = {:a => .., :b => ..}
        @inboxes = {:a => [], :b => []}
        server = Faye::RackAdapter(:mount => '/')
        Thread.new { server.listen 8000 }
      end
      
      it "sends messages I guess" do
        @clients[:b].subscribe '/foo' do |message|
          @inboxes[:b] << message
        end
        EM.add_timer(0.1) do
          @clients[:a].publish('/foo', 'hello' => 'world')
          EM.add_timer(0.3) do
            @inboxes[:b].should == [ {'hello' => 'world'} ]
            @inboxes[:a].should be_empty
          end
        end
      end
    end


!SLIDE commandline
# You’re holding it wrong
    $ rspec spec/client_spec.rb
    F
    
    1) Faye::Client sends messages I guess
       Failure/Error: wut?!
       expected: a spec I can read
            got: WTF


!SLIDE center
# Reg Braithwaite

“This is patently wrong: there’s nothing inherently nested about what we’re trying to do.”


!SLIDE
# Tests MUST be readable

    @@@ ruby
                 Scenario: Alice sends a message to Bob
                   Given there is a server running on port 8000
     nice          And "Alice" has no subscriptions
     straight ---> And "Bob" is subscribed to "/foo"
     line          When "Alice" publishes a message to "/foo"
                   Then "Bob" should receive the message


!SLIDE
# Tell us a story

    @@@ ruby
    scenario "message from Alice to Bob" do
      server 8000
      
      client :alice, []
      client :bob,   [ '/foo' ]
      
      publish :alice, '/foo', {'hello' => 'world'}
      
      check_inbox :bob,   [ {'hello' => 'world'} ]
      check_inbox :alice, []
    end


!SLIDE callout
# Yeah, but--
## I know. It’s going to be okay.


!SLIDE
# Make test actions with callbacks

    @@@ ruby
    class AsyncScenario
      def initialize
        @clients = {}
        @inboxes = {}
      end
      
      def server(port, &resume)
        @port   = port
        server  = Faye::RackAdapter.new(:mount => '/')
        handler = Rack::Handler.new('thin')
        
        handler.run(server, :Port => @port) do
          resume.call
        end
      end
    end


!SLIDE
# Make test actions with callbacks

    @@@ ruby
    class AsyncScenario
      def client(name, channels, &resume)
        endpoint = "http://0.0.0.0:#{@port}/"
        client   = Faye::Client.new(endpoint)
        
        channels.each do |channel|
          client.subscribe(channel) do |message|
            @inboxes[name] << message
          end
        end
        
        @clients[name] = client
        @inboxes[name] = []
        
        EM.add_timer(0.2) { resume.call }
      end
    end


!SLIDE
# Queue up commands

    @@@ ruby
    class ClientTest < Test::Unit::TestCase
      def setup
        @scenario = AsyncScenario.new
        @commands = []
        @started  = false
        Faye.ensure_reactor_running!
      end
      
      def method_missing(*command_args)
        @commands << command_args
        EM.next_tick { run_next_command unless @started }
      end
      
      def teardown
        sleep 0.1 while EM.reactor_running?
      end
    end


!SLIDE
# Run command and schedule next

    @@@ ruby
    class ClientTest
      def run_next_command
        @started = true
        command  = @commands.shift
        
        return EM.stop if @command.nil?
        
        @scenario.send(*command) { run_next_command }
        
      rescue Object => e
        add_failure(e.message, e.backtrace)
      end
    end
