!SLIDE bullets
# Functions

* Functions are data (lambdas)
* They can be nested (closures)
* Define scope of variables
* No Ruby-style default value syntax
* No special slots (e.g. like `&` for blocks)
* Variable arity


!SLIDE
# Functions

```javascript
// function declaration
function add(x, y) {
  return x + y;
};

// function expression
var add = function(x, y) {
  return x + y;
};

// call with parens
add(2,2) // -> 4

// call with too many args
add(2,2,2) // -> 4

// call with too few args
add(2) // -> NaN
```

!SLIDE
# `arguments`

```javascript
// All functions have a special `arguments`
// object. It's array-like, but is not an Array.

var alertArgs = function() {
  alert(arguments.length + " :: " + arguments[0]);
};

alertArgs(3)    // alerts "1 :: 3"
alertArgs(5,8)  // alerts "2 :: 5"

// arguments.callee refers to the current function
var factorial = function(x) {
  if (x === 0) return 1;
  return x * arguments.callee(x - 1);
};
```

!SLIDE
# Optional arguments

```javascript
// There's no syntax support for objects as final
// arguments. e.g. you cannot do, as in Ruby:
hasMany("artists", through: "trackings")

// have to include the braces:
hasMany("artists", {through: "trackings"})

// There is no default-arg syntax. Common pattern:
var hasMany = function(associationName, options) {
  options = options || {};
  // ...
};
```

!SLIDE
# Opening braces go at
# the end of the line
## SRSLY.


!SLIDE
# Closures

```javascript
var add = function(x) {
  return function(y) {
    return x + y;
  };
};

add(2)    //-> function()
add(2)(2) //-> 4
```

!SLIDE
# Closures

```javascript
var makeCounter = function() {
  var count = 0;
  return function() {
    count += 1;
    return count;
  };
};

var counter = makeCounter();
counter() //-> 1
counter() //-> 2
counter() //-> 3
```

!SLIDE
# Closures

```javascript
// beware - all timeouts will see the final value of i
for (var i = 0; i < 10; i += 1) {
  setTimeout(function() {
    displayImage(images[i]);
  }, i * 1000);
}

// capture each i using a closure
var displayWithTimeout = function(x) {
  setTimeout(function() {
    displayImage(images[x]);
  }, x * 1000);
};
for (var i = 0; i < 10; i += 1)
  displayWithTimeout(i);

// or use an iterator
$.each(images, function(i, image) {
  setTimeout(function() {
    displayImage(image);
  }, i * 1000);
});
```

!SLIDE
# Closures as templates

```javascript
var log = function(pseudoUrl) {
  return function() {
    pageTracker._trackPageview("/behavior/" + pseudoUrl);
  };
};

$(".signup").bind("click", log("signup-link"));

// -> $(".signup").bind("click", function() {
//      pageTracker._trackPageview("/behavior/signup-link");
//    });
```