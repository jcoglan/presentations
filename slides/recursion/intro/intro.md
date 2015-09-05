!SLIDE title
## http://slides.jcoglan.com
# Why recursion matters
## James Coglan


!SLIDE

> Not the wind, not the flag—neither one is moving, nor is anything moving at
> all. For I have discovered a great Theorem, which states: “Motion is
> Inherently Impossible.”

<cite>Douglas Hofstadter, *Gödel, Escher, Bach*</cite>


!SLIDE

```js
function getElementsByTagName(name, root) {
  root = root || document.body

  var elements = [],
      children = root.childNodes

  if (root.tagName === name)
    elements.push(root)

  for (var i = 0, n = children.length; i < n; i++)
    elements = elements.concat(
      getElementsByTagName(name, children[i])
    )

  return elements
}
```


!SLIDE

```js
function spider(pageUrl) {
  fetch(pageUrl).then(function(response) {
    return response.text()

  }).then(function(html) {
    jsdom.env(html, function(error, window) {
      var body  = window.document.body,
          links = getElementsByTagName('A', body)

      var urls = links.map(function(link) {
        return url.resolve(pageUrl, link.href)
      })

      urls.forEach(spider)
    })
  })
}
```


!SLIDE title

# Procedures
## vs.
# Structures


!SLIDE

```js
var person = {name: 'james'}

var p1 = Object.create(person)
// p1.__proto__ == person

var p2 = Object.create(p1)
// p2.__proto__ == p1
```


!SLIDE

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
# Meanings
