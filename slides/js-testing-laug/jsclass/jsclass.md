!SLIDE bullets
# JS.Class

* An object system for JavaScript
* Based on Ruby
* Classes, mixins, data structures


!SLIDE
# Making classes

    @@@ javascript
    OrderedHash = new JS.Class('OrderedHash', {
      include: JS.Enumerable,
      
      initialize: function() {
        // ...
      },
      
      forEach: function(callback, context) {
        // ...
      }
    })


!SLIDE
# Loading code

    @@@ javascript
    JS.Packages(function() { with(this) {
      
      file('/lib/js/ordered_hash.js')
        .provides('OrderedHash')
        .requires('JS.Class', 'JS.Enumerable')
      
      file('http://cdn.google.com/jquery.js')
        .provides('jQuery', '$')
    }})
    
    JS.require('jQuery', 'OrderedHash', function() {
      var links = $('a'),
          hash  = new OrderedHash()
      
      // ...
    })


!SLIDE
# Loading code

    @@@ javascript
    JS.Packages(function() { with(this) {
      
      file('https://www.google.com/jsapi?key=INSERT-YOUR-KEY')
        .provides('google.load')
      
      loader(function(onload) {
        google.load('maps', '2', {callback: onload})
      })
        .provides('google.maps')
        .requires('google.load')
    }})
    
    JS.require('google.maps', function() {
      var node = document.getElementById("map"),
          map  = new google.maps.Map2(node)
    })


!SLIDE
# Loading code

    @@@ javascript
    JS.Packages(function() { with(this) {
      
      autoload(/^(.*)Spec$/, {
               from: 'test/specs',
               require: '$1' })
      
      // e.g. TwitterSpec
      //      defined in test/specs/twitter_spec.js
      //      requires Twitter
    })


!SLIDE callout
# “Does it work on Node?”


!SLIDE center
# I don’t know
![Scripty tests](scripty.png)


!SLIDE bullets
# JS.Test

* Should run everywhere
* Remove boilerplate
* Hide platform differences

