!SLIDE callout
# Internals
## Generic tools + bindings for data stores


!SLIDE
# `Watcher` module

```ruby
class Widget
  include Primer::Watcher
  watch_calls_to :name

  attr_writer :name

  def name(*args)
    @name
  end
end
```

!SLIDE
# `Watcher` module

```ruby
widget = Widget.new
widget.name = "Dashboard"

calls = []

result = Primer::Watcher.watching(calls) do
  widget.name
end

result # => "Dashboard"

calls # => [
      #      [#<Widget:0x866bcd4 @name="Dashboard">,
      #        :name, [], nil, "Dashboard"]
      #    ]
```

!SLIDE
# `Watcher` module

```ruby
calls = []

Primer::Watcher.watching(calls) do
  widget.name(:some, :args) { p :hi }
end

calls # => [
      #      [#<Widget:0x866bcd4 @name="Dashboard">,
      #        :name,
      #        [:some, :args],
      #        #<Proc:0x85f7eec@(irb):26>,
      #        "Dashboard"]
      #    ]
```

!SLIDE
# `Cache#compute`

```ruby
# Takes a key and a block. If key is in the cache,
# return its value. Otherwise: run the block, record
# which data are used, cache and return the result.

Primer.cache.compute("/concerts/1/title") do
  Concert.find(1).title.upcase
end

# Returns "TITLE OF CONCERT"

# Records that "/concerts/1/title" depends on the data:
#
#     ["ActiveRecord", "Concert", 1, "title"]
```

!SLIDE
# Self-aware

```ruby
# The cache is itself watchable, so we know when
# one cache value depends on others:
Primer.cache.compute("/foo") do
  Primer.cache.compute("/bar") do
    Concert.find(1).title.upcase
  end
end

# "/bar" depends on:
#     ["ActiveRecord", "Concert", 1, "title"]
#
# "/foo" depends on:
#     ["ActiveRecord", "Concert", 1, "title"]
#     ["Primer::Cache", "get", "/bar"]
```

!SLIDE
# Publishing updates

```ruby
# When an ActiveRecord object changes, publish it

class ActiveRecord::Base
  after_update :notify_primer_about_update

  def notify_primer_about_update
    Primer.bus.publish(:active_record, :update, self)
  end
end
```

!SLIDE
# Interpreting updates

```ruby
# ActiveRecordAgent takes the message and figures out
# which attributes have changed...

class Primer::Worker::ActiveRecordAgent
  Primer.bus.subscribe(:active_record) do |event, object|
    ActiveRecordAgent.send("on_#{event}", object)
  end

  def self.on_update(object)
    object.changes.each do |attribute, (old_v, new_v)|
      change = ["ActiveRecord", object.class.name,
                object.id, attribute.to_s]

      Primer.bus.publish(:changes, change)
    end
  end
end
```

!SLIDE
# Publish related changes

```ruby
>> alice, bob = User.find(1), User.find(2)

>> post = BlogPost.find(1)
=> #<BlogPost id: 1, user_id: 1>

>> post.update_attribute(:user, bob)

#=> Published changes:
#   ["ActiveRecord", "BlogPost", 1, "user_id"]
#   ["ActiveRecord", "BlogPost", 1, "user"]
#   ["ActiveRecord", "User", 1, "blog_posts"]
#   ["ActiveRecord", "User", 2, "blog_posts"]
```

!SLIDE
# Cache reacts to changes

```ruby
Primer.bus.subscribe(:changes) do |attribute|
  Primer.cache.changed(attribute)
end

class Primer::Cache
  # attribute is an identifier tuple, e.g.
  # ["ActiveRecord", "Concert", 1, "title"]
  def changed(attribute)
    keys_affected_by(attribute).each do |key|
      invalidate(key)
      regenerate(key)
    end
  end
end
```

!SLIDE
# Real-time updates

```html
<%= primer "/some/cache/key" %>

// outputs...
<div id="primer-some-cache-key">BLAH</div>
<script type="text/javascript">
  PRIMER_KEYS.push("/some/cache/key")
</script>
```

!SLIDE
# Real-time updates

```javascript
var endpoint   = '/primer/bayeux',
    fayeClient = new Faye.Client(endpoint);

PRIMER_KEYS = {
  push: function(key) {
    fayeClient.subscribe(key, function(message) {
      var node = document.getElementById(message.dom_id);
      node.innerHTML = message.content;
    });
  }
};
```

!SLIDE
# Real-time updates

```ruby
# when the cache is updated:
Primer.cache.put("/some/cache/key", "UPDATED")

client = Faye::Client.new("http://www.songkick.com/...")

client.publish("/some/cache/key",
  "dom_id"  => "primer-some-cache-key",
  "content" => "UPDATED")
```