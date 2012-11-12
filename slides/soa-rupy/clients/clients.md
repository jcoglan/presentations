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

