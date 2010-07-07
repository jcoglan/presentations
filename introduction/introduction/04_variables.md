!SLIDE bullets
# Variables

* Valid names: `/^[a-z\$\_][a-z0-9\$\_]*$/i`
* Variables do not have types
* Local variables are declared with `var`
* Functions define variable scope
* Omitting `var` creates global variables


!SLIDE bullets
# Variables

    @@@ javascript
    var company  = "Songkick";
    var founders = ["Ian", "Michelle", "Pete"];
    
    // use commas do make multiple declarations
    var company  = "Songkick",
        founders = ["Ian", "Michelle", "Pete"];
    
    // don't need an initial value
    var declareFirst;


!SLIDE
# Always use `var`
## Or God kills a kitten.

