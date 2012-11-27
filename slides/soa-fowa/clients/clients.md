!SLIDE bullets
# HTTP introduces complexity
* Serializing parameters and responses
* Query strings vs entity bodies
* Multipart uploads
* Hostname discovery
* DNS failure
* Connection failure
* Response timeout
* Validation errors


!SLIDE title
# Solve each problem once


!SLIDE bullets
# Client-side goals
* Minimal integration code
* Easy to stub out
* Straight-forward error handling
* Instrumentation


!SLIDE
# Difficult

    @@@ruby
    uri = URI.parse("http://accounts/users/#{name}")
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request_get(uri.path)
    if response.code == '200'
      JSON.parse(response.body)
    else
      raise NotFound
    end


!SLIDE
# Easy

    @@@ruby
    http = Songkick::Transport::Curb.new('http://accounts')
    http.get("/users/#{name}").data


!SLIDE bullets
# Songkick::Transport
* JSON over HTTP
* Handles serialization and parsing
* Same API over Curb, HTTParty or Rack::Test
* All types of errors raise exceptions


!SLIDE

    @@@ruby
    module Services
      
      class AccountsClient
        def initialize(http_client)
          @http = http_client
        end

        def find_user(username)
          data = @http.get("/users/#{username}").data
          Models::User.new(data)
        end
      end
      
    end


!SLIDE

    @@@ruby
    module Models
      
      class User
        def initialize(data)
          @data = data
        end

        def username
          @data['username']
        end
      end
      
    end


!SLIDE

    @@@ruby
    before do
      @http   = mock('Transport')
      @client = Services::AccountsClient.new(@http)
    end

    it "returns a User" do
      data = {'username' => 'jcoglan'}
      response = mock('Response', :data => data)
      
      @http.stub(:get).with('/users/jcoglan').
          and_return(response)
      
      @client.find_user('jcoglan').username.
          should == 'jcoglan'
    end


!SLIDE

    @@@ruby
    it "tells the service to delete a User" do
      @http.should_receive(:delete).with('/users/jcoglan')
      @client.delete_user('jcoglan')
    end


!SLIDE
# Stubbable

    @@@ruby
    http.get('/', :foo => 'bar', :something => 'else')


!SLIDE
# Not stubbable

    @@@ruby
    http.get('/?foo=bar&something=else')


!SLIDE title
# Flexibility vs. convenience
## Pick the first, and you can add the second later


!SLIDE
# Flexible

    @@@ruby
    http   = Songkick::Transport::Curb.new('...')
    client = Services::AccountsClient.new(http)
    user   = client.find_user(params[:username])


!SLIDE
# Convenient

    @@@ruby
    user = Services.accounts.find_user(params[:username])


!SLIDE
# Provide a convenient default

    @@@ruby
    module Services
      
      def self.accounts
        @accounts ||= begin
          endpoint = 'http://accounts-service'
          http = Songkick::Transport::Curb.new(endpoint)
          AccountsClient.new(http)
        end
      end
      
    end


!SLIDE bullets
# Result:
* Convenient and flexible API for service calls
* Interfaces can be stubbed for tests
* No I/O means fast tests

