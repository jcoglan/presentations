!SLIDE center
# What is event-driven programming?


!SLIDE
# You’re already doing it

```ruby
class BlogPostsController < ApplicationController
  def create
    @post = BlogPost.create(params[:blog_post])
    if @post.save
      flash[:notice] = 'Your post was created!'
      redirect_to(dashboard_path)
    else
      render(:template => 'blog_posts/form')
    end
  end
end
```

!SLIDE callout
# Tell, don’t ask


!SLIDE callout
# Don’t call us, we’ll call you


!SLIDE center
# Alan Kay on objects

“I thought of objects being like biological cells, only able to
communicate with messages. OOP to me means only messaging, local
retention and protection and hiding of state-process.”


!SLIDE callout
# Never block
## What if there were no `return`?


!SLIDE
# Continuation-passing style

```ruby
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
```
