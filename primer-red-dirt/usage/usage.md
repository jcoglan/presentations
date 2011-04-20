!SLIDE center
# README


!SLIDE
# Watch the models

    @@@ ruby
    class Artist < ActiveRecord::Base
      has_many :performances
      has_many :concerts, :through => :performances
      # etc.
      
      include Primer::Watcher
    end


!SLIDE
# Add view helper

    @@@ ruby
    # Sinatra
    helpers { include Primer::Helpers::ERB }
    
    # Rails
    module ApplicationHelper
      include Primer::Helpers::ERB
    end


!SLIDE
# Configure cache

    @@@ ruby
    Primer.cache = Primer::Cache::Redis.new
    Primer.cache.bind_to_bus


!SLIDE bullets
# Cache your output

    @@@ html
    <% primer "/concerts/#{@concert.id}/summary" do %>
      
      <h1><%= @concert.date.strftime('%A %e %B %Y') %></h1>
      <h2><%= @concert.venue.name %></h2>
      <ul>
        <% @concert.performances.each do |performance| %>
          <li><%= performance.artist.name %></li>
        <% end %>
      </ul>
      
    <% end %>
