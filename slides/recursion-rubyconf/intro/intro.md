!SLIDE title
# Why recursion matters
## James Coglan


!SLIDE

> Not the wind, not the flag—neither one is moving, nor is anything moving at
> all. For I have discovered a great Theorem, which states: “Motion is
> Inherently Impossible.”

<cite>Douglas Hofstadter, *Gödel, Escher, Bach*</cite>


!SLIDE code

```ruby
def rm_rf(pathname)
  if File.file?(pathname)
    File.unlink(pathname)
  elsif File.directory?(pathname)
    children = Dir.entries(pathname) - %w[. ..]
    children.each do |child|
      rm_rf(File.join(pathname, child))
    end
    Dir.unlink(pathname)
  end
end
```


!SLIDE code

```ruby
def spider(url)
  uri  = URI.parse(url)
  html = Net::HTTP.get_response(uri).body

  links = Nokogiri::HTML(html).search('a').map do |a|
    URI.join(uri, a[:href]).to_s
  end

  links.each do |link|
    spider(link)
  end
end
```


!SLIDE title

# Procedures
## vs.
# Structures


!SLIDE code

```js
var person = {name: 'james'}

var p1 = Object.create(person)
// p1.__proto__ == person

var p2 = Object.create(p1)
// p2.__proto__ == p1
```


!SLIDE code

```js
p2.name // -> p2.hasOwnProperty('name') -> false
        //    p2.__proto__.name

        //    p1 = p2.__proto__
        //    p1.hasOwnProperty('name') -> false
        //    p1.__proto__.name

        //    person = p1.__proto__
        //    person.hasOwnProperty('name') -> true

        //    person.name
        //    -> 'james'
```


!SLIDE title
# Correctness
# Performance
# Meaning
