!SLIDE callout
# README


!SLIDE
# Watch the models

```ruby
class Artist < ActiveRecord::Base
  has_many :performances
  has_many :concerts, :through => :performances
  # etc.

  include Primer::Watcher
end
```

!SLIDE
# Add view helper

```ruby
# Sinatra
helpers { include Primer::Helpers::ERB }

# Rails
module ApplicationHelper
  include Primer::Helpers::ERB
end
```

!SLIDE
# Configure cache

```ruby
Primer.cache = Primer::Cache::Redis.new
Primer.cache.bind_to_bus
```

!SLIDE bullets
# Cache your output

```html
<% primer "/concerts/#{@concert.id}/title" do %>
  <%= @concert.title.upcase %>
<% end %>
```

* Cache keys are paths
* Output is cached
* View uses `@concert.title`


!SLIDE
# Don’t write observers!

```ruby
>> Primer.cache.get("/concerts/1/title")
=> "OMG IT'S WEB SCALE!"

>> concert = Concert.find(1)
=> #<Concert id: 1, title: "OMG it's web scale!">
>> concert.update_attribute(:title, "Changed!")
=> true

>> Primer.cache.get("/concerts/1/title")
=> nil
```

!SLIDE
# Declare generators

```ruby
# config/primer.rb
Primer.cache.routes do
  get '/concerts/:id/title' do
    concert = Concert.find(params[:id])
    concert.title.upcase
  end
end

# views/concerts/show.html.erb
<%= primer "/concerts/#{@concert.id}/title" %>
```

!SLIDE
# It updates automagically

```ruby
>> Primer.cache.get("/concerts/1/title")
=> "OMG IT'S WEB SCALE!"

>> concert = Concert.find(1)
=> #<Concert id: 1, title: "OMG it's web scale!">
>> concert.update_attribute(:title, "Changed!")
=> true

>> Primer.cache.get("/concerts/1/title")
=> "CHANGED!"
```

!SLIDE
# Precompute data

```ruby
class ConcertObserver < ActiveRecord::Observer
  def after_create(concert)
    Primer.cache.compute("/concerts/#{concert.id}/title")
  end
end
```

!SLIDE
# Move computing offline

```ruby
# config/primer.rb
Primer.bus = Primer::Bus::AMQP.new

# script/worker.rb
require 'config/environment'
Primer.worker!
```

!SLIDE
# Throttling

```ruby
Primer.cache.throttle = 5

Primer.routes do
  get "/some/key" do
    concert = Concert.first
    concert.artists.map { |a| a.name } * ', '
  end
end

# Change #<Artist:1>.name and #<Artist:2>.name
# within 5 seconds => only one regeneration
```

!SLIDE
# Real-time updates

```ruby
# config/primer.rb
Primer.real_time = true
Primer::RealTime.bayeux_server = "http://www.songkick.com"
Primer::RealTime.password = "a-billion-concerts"

# config.ru
use Primer::RealTime
run Application

# views/layout.html.erb
<script src="/primer.js"></script>

<%= primer "/some/expensive/view" %>
```
