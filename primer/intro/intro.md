!SLIDE frontpage
# Primer
## The Cache That Knows Too Much


!SLIDE bullets
# `whoami`

* James Coglan - @jcoglan
* Developer at Songkick.com
* Open source: Faye, Heist, JS.Class


!SLIDE callout
# There are only two hard problems in Computer Science


!SLIDE callout
# Cache invalidation


!SLIDE callout
# Naming things


!SLIDE callout
# Off-by-one errors


!SLIDE bullets
# Cache invalidation

* Tedious to write code
* Tightly coupled to implementation
* Hard to test without deep knowledge
* Bugs, missed deadlines, pain


!SLIDE
# The Rails way

    @@@ ruby
    class TrackingObserver < ActiveRecord::Observer
      def after_create(tracking)
        case tracking.subject
        when Artist
          artist = tracking.subject
          city = tracking.user.metro_area
          artist.concerts.upcoming.near(city).each do |concert|
            tracking.user.update_calendar(concert, :tracked_artist)
          end
        when City
          # ...
        end
      end
    end


!SLIDE
# Our way

    @@@ ruby
    class ActivityRecorder < ActiveRecord::Observer
      observe Tracking, Artist # ...
      
      def after_create(object)
        Messaging.broadcast_change(:create, object)
      end
    end
    
    # offline
    listen :create, Tracking, Artist do
      artist = tracking.subject
      city = tracking.user.metro_area
      # ...
    end


!SLIDE center
# 
![Call graph](call-graph.png)


!SLIDE frontpage
# :-(


!SLIDE bullets
# Songkick LOC

* Messaging: 338
* Silo: 570
* Renderers: 330
* Silovator: 2,500
* Apivator: 1,308
* ++ tests, cukes, config


!SLIDE bullets incremental
# Primer

* Invalidates caches
* Has a name
* Double win!


!SLIDE bullets
# There’s more

* Data caching
* Dependency monitoring
* Cache expiry and regeneration
* Change notification
* Offline processing
* Real-time updates
* ActiveRecord integration

