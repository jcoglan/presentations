!SLIDE bullets
# Constructors

* Constructors are just functions
* Each constructor has a `prototype` object
* New objects inherit from this prototype
* By convention they have uppercase names
* They must be called with `new`


!SLIDE bullets
# Constructors

    @@@ javascript
    var Person = function(name) {
      this.name = name;
    };
    
    Person.prototype.sayHello = function(greeting) {
      return greeting + ", " + this.name;
    };
    
    var jcoglan = new Person("jcoglan");
    
    jcoglan.sayHello("Howdy")
    // -> "Howdy, jcoglan"


!SLIDE bullets
# Constructors

    @@@ javascript
    // the expression `var user = new Person("jcoglan")`
    // is exactly equivalent to:
    
    var user = {};
    user.__proto__ = Person.prototype;
    Person.call(user, "jcoglan");
    
    // user has its own instance variables,
    // but inherits its methods
    
    user.hasOwnProperty("name")     // -> true
    user.hasOwnProperty("sayHello") // -> false

