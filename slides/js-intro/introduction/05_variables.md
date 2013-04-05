!SLIDE bullets
# Variables

* Valid names: `/^[a-z\$\_][a-z0-9\$\_]*$/i`
* Variables do not have types
* Local variables are declared with `var`
* Functions define variable scope
* Omitting `var` creates global variables


!SLIDE bullets
# Variables

```javascript
var company  = "Songkick";
var founders = ["Ian", "Michelle", "Pete"];

// use commas do make multiple declarations
var company  = "Songkick",
    founders = ["Ian", "Michelle", "Pete"];

// don't need an initial value
var declareFirst;
```

!SLIDE bullets
# Don't create globals

```javascript
// Create an anonymous function to contain
// the variables, then immediately call it
(function() {
  var someData = 12;
  // do work...
})();

// (function() { ... })()
//  ^                ^  ^
//  |                |  |
//  ------------------  |
//          |           |
//      create the     call!
//       function
```

!SLIDE
# Always use `var`
## Or God kills a kitten.

