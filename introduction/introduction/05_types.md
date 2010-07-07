!SLIDE bullets
# Object types

* `Object`: `{foo: "bar"}`
* `Array`: `["foo", "bar"]`
* `Function`
* `RegExp`: `/foo|bar/i`
* `Date`


!SLIDE bullets
# Object types

* Mutable (very mutable)
* Pass by reference


!SLIDE bullets
# Type detection

* `typeof true  == "boolean"`
* `typeof 45    == "number"`
* `typeof "hi"  == "string"`
* `typeof alert == "function"`


!SLIDE bullets
# Type detection
* `typeof {}    == "object"`
* `typeof []    == "object"`
* `typeof null  == "object"`
* `typeof undefined == "undefined"`


!SLIDE bullets
# Type detection

* `{} instanceof Object == true`
* `[] instanceof Array  == true`
* `alert instanceof Function == true`
* `/foo/ instanceof RegExp == true`
* `null instanceof Object == false`


!SLIDE bullets
# Beware!

* `typeof NaN == "number"`
* `NaN == NaN // -> false`

