!SLIDE center
# Primer
## The cache that knows too much


!SLIDE center
# There are only two hard problems in Computer Science


!SLIDE center
# Cache invalidation


!SLIDE center
# Naming things


!SLIDE
# Who enjoys this?

    @@@ruby
    <% cache(:action_suffix => "all_topics") do %>
      <%= Topic.find(:all).map { ... } %>
    <% end %>
    
    class TopicObserver < ActiveRecord::Observer
      def after_create(topic)
        expire_fragment(:controller    => "topics",
                        :action        => "list",
                        :action_suffix => "all_topics")
      end
      
      def after_destroy(topic)
        # etc.
      end
    end


!SLIDE bullets
# Hi, there!

* James Coglan
* jcoglan on GitHub / Twitter
* Wrote Faye, Heist


!SLIDE center
## (We’re hiring)
![Songkick](sk-home.png)


!SLIDE center
![Call graph](call-graph.png)


!SLIDE center
## 1000.times { puts “Don’t repeat yourself!”  }


!SLIDE
# Isn’t this enough?

    @@@ruby
    <% cache "/concerts/#{@concert.id}/title" do %>
      <%= @concert.title.upcase %>
    <% end %>
    
    # key "/concerts/#{@concert.id}/title"
    # depends on @concert.title. It says so
    # right there!


!SLIDE bullets incremental
# Primer

* Invalidates caches
* Has a name
* 1,488 LOC (inc. tests)


!SLIDE bullets
# But wait, there’s more!

* Dependency monitoring
* Cache expiry and regeneration
* Offline processing
* Real-time page updates
* ActiveRecord integration
