!SLIDE bullets
# Classes

* JavaScript does not have classes
* It has constructor functions and prototypes
* Yeah, I know. Don't ask.


!SLIDE
# Prototypes

    @@@ javascript
    var object1 = {name: "jcoglan"};
    var object2 = {company: "Songkick"};
    
    object2.name // -> undefined
    
    object2.__proto__ = object1;
    object2.name // -> "jcoglan"
    
    object2.hasOwnProperty("company") // -> true
    object2.hasOwnProperty("name")    // -> false

