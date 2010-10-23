!SLIDE bullets
# Primitive types

* Booleans: `true`, `false`
* Numbers: `45`, `3.14159`, `0755`, `0xFF`
* Strings: `"Hello world"`
* `null`, `NaN`, `undefined`
* No symbols or integers


!SLIDE bullets
# Primitive types

* Immutable
* Pass by value
* Have constructors
* `Boolean`, `Number`, `String`


!SLIDE bullets
# Numbers

* No floats, fixnums, etc. Just `Number`
* All numbers are 64-bit floating point
* Operators are _not_ methods
* Useful stuff in `Math` module


!SLIDE bullets
# Parsing

* `parseInt("67") == 67`
* `parseInt("047") == 39`
* `parseInt("047", 10) == 47`
* Always use a radix


!SLIDE bullets
# Strings

* Immutable, no native interpolation
* Single- or double-quoted
* Unicode
* Concatenation with `+` gives a new string
* `"Hello".length` gives `5`
* Regex methods: `match()`, `replace()`


!SLIDE bullets
# Logical values

* `false`, `0`, `""`, `null`, `undefined` are falsey
* All other primitives are truthy
* All objects are truthy

