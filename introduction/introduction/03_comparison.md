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


!SLIDE
# Always use `===`
## I'm not kidding.

