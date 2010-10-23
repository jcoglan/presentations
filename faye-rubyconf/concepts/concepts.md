!SLIDE center
# What is event-driven programming?


!SLIDE
# You’re already doing it

    @@@ ruby
    class BlogPostsController < ApplicationController
      def create
        @post = BlogPost.create(params[:blog_post])
        redirect_to dashboard_path if @post.save
      end
    end


!SLIDE callout
# Tell, don’t ask


!SLIDE center
# Alan Kay on OOP

"OOP to me means only messaging, local retention and protection and 
hiding of state-process."


!SLIDE callout
# Never block
## What if there were no `return`?


!SLIDE
# Continuation-passing style

    @@@ ruby
    # Blocking
    
    response = HTTParty.post(url, :query => {:q => 'blocking'})
    # process response ...
    
    
    # Non-blocking
    
    req = EM::HttpRequest.new(url).post(:body => 'q=blocking')
    
    req.callback do
      response = req.response
      # process response ...
      
      puts 'This happens last'
    end
    
    puts 'This happens first'


!SLIDE bullets
# Event-driven programming

* Keeps components decoupled
* Expresses _why_ and _when_, not just _what_
* Help with non-blocking I/O

