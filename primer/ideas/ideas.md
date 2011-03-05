!SLIDE bullets
# Ideas

* Lazy-loading
* SSI inegration


!SLIDE
# Lazy-loading

    @@@ ruby
    # Don't load the model
    concert = Concert.find(1)
    
    # Doesn't load the model
    concert.id
    
    # Loads the model
    concert.venue


!SLIDE
# SSI integration

    @@@ ruby
    # view.html.erb
    <%= primer "/some/cache/key" %>
    # => <!--# include virtual="/primer/some/cache/key" -->
    
    # nginx.conf
    server {
      listen 80;
      server_name www.songkick.com;
      ssi on;
      
      location /primer/ {
        internal;
        proxy_pass http://primer-cache:9292/
      }
    }


!SLIDE
# SSI integration

    @@@ ruby
    # config.ru
    
    class Application
      def call(env)
        request = Rack::Request.new(env)
        html = Primer.cache.compute(request.path_info)
        [
          html ? 200 : 404,
          {'Content-Type' => 'text/html'},
          [html]
        ]
      end
    end
    
    run Application.new

