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


!SLIDE
# Tests MUST be readable

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

