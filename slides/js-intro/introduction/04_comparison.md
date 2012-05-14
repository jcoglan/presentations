!SLIDE bullets
# Comparison

* Comparators are not methods
* All the usual ordering operators
* `<`, `<=`, `>`, `>=`


!SLIDE bullets
# Equality

* Two equality operators: `==` and `===`
* `==` is not type-safe: `4 == "4"` is `true`
* `===` is type-safe: `4 === "4"` is `false`
* No deep-equality for arrays or objects
* Negatives are `!=` and `!==`


!SLIDE bullets
# Equality and logic

* Be careful with booleans
* `!false`, `!0`, `!""`, `!null` are `true`
* `0 && 5` is `0`
* `"" || "foo"` is `"foo"`


!SLIDE
# Default values

    @@@javascript
    var myFunc = function(x) {
      x = x || 5;
      alert(x);
    };
    
    myFunc(0) // alerts "5"
    
    var betterFunc = function(x) {
      if (x === undefined) x = 5;
      alert(x);
    };
    
    betterFunc(0) // alerts "0"


!SLIDE
# Always use `===`
## I'm not kidding.

