!SLIDE center
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
def patch_method_for_primer(method_name)
  alias_name = Macros.alias_name(method_name)
  return unless method = instance_method(method_name)

  class_eval <<-MONKEY_PATCH
    alias :#{alias_name} :#{method_name}
    def #{method_name}(*args, &block)
      result = #{alias_name}(*args, &block)
      data = [self, :#{method_name}, args, block, result]
      Primer::Watcher.log(*data)
      result
    end
  MONKEY_PATCH
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
Primer.cache.compute("/concerts/1/summary") do
  concert = Concert.find(1)
  concert.date.strftime('%A %e %B %Y') + ': ' +
  concert.performances.map { |p| p.artist.name }
end

# Returns "Monday 18 April 2011: Justin Bieber..."

# Records that "/concerts/1/summary" depends on the data:
#
#     ["ActiveRecord", "Concert", 1, "date"]
#     ["ActiveRecord", "Concert", 1, "performances"]
#     ["ActiveRecord", "Performance", 1, "artist"]
#     ["ActiveRecord", "Artist", 2, "name"]
```

!SLIDE smaller
# Internal representation

```ruby
["ActiveRecord", "Concert", 1, "date"]           => ["/concerts/1/summary"]
["ActiveRecord", "Concert", 1, "performances"]   => ["/concerts/1/summary"]

["ActiveRecord", "Performance", 1, "artist"]     => ["/concerts/1/summary"]
["ActiveRecord", "Performance", 2, "artist"]     => ["/concerts/1/summary"]

["ActiveRecord", "Artist", 2, "name"]            => ["/concerts/1/summary",
                                                     "/artists/2/summary"]

["ActiveRecord", "Artist", 3, "name"]            => ["/concerts/1/summary",
                                                     "/artists/3/summary"]
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

Primer.bus.subscribe(:active_record) do |event, object|
  object.changes.each do |attribute, (old_v, new_v)|

    change = ["ActiveRecord", object.class.name,
              object.id, attribute.to_s]

    # change = ["ActiveRecord", "Artist", 2, "name"]
    Primer.bus.publish(:changes, change)
  end
end
```

!SLIDE
# Publish related changes

```ruby
# e.g. object = #<Performance:1>, attribute = "artist_id"

assoc = object.class.reflect_on_all_associations.
        select { |a| a.macro == :belongs_to }.
        find { |a| a.primary_key_name == attribute }

# assoc = #<AssociationReflection
#             @macro=:belongs_to @name=artist>

Primer.bus.publish(:changes,
    object.primer_identifier + [assoc.name])

# Get Artist.has_many(:performances) association...
has_many = assoc.class_name.constantize.
           reflect_on_all_associations.
           select { |a| a.macro == :has_many }
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

!SLIDE center
# Pre-generation
![Top of Google](google-first.png)


!SLIDE center
# Nooooooobody gonna visit you
![Google page 20](google-20.png)


!SLIDE
# Pre-generation

```ruby
<%= primer "/concerts/1/summary" %>

# with a little help from Sinatra
Primer.cache.routes do
  get "/concerts/:id/summary" do
    concert = Concert.find(params[:id])
    concert.title.upcase +
    concert.date.strftime('%A %e %B %Y') +
    concert.performances.map { |p| p.artist.name }
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

```ruby
# when the cache is updated:
Primer.cache.put("/some/cache/key", "UPDATED")

client = Faye::Client.new("http://www.songkick.com/...")

client.publish("/some/cache/key",
    "dom_id"  => "primer-some-cache-key",
    "content" => "UPDATED")
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