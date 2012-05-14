!SLIDE
# OOP = objects + functions
## Where we're going, we don't need a class system.


!SLIDE bullets
# Object orientation

* Any function can be applied to any object
* Two important methods: `call()` and `apply()`
* You can specify the `this` binding


!SLIDE
# Object orientation

    @@@javascript
    var user = {name: "jcoglan"};
    
    var sayHello = function(greeting) {
      return greeting + ", " + this.name;
    };
    
    sayHello.call(user, "Hi there");
    // -> "Hi there, jcoglan"
    
    sayHello.apply(user, ["Hi there"]);
    // -> "Hi there, jcoglan"
    
    // `this` refers to the global object
    sayHello("Hi there");
    // -> "Hi there, "


!SLIDE
# Object orientation

    @@@javascript
    // we can store functions in objects
    var user = {
      name: "jcoglan",
      
      sayHello: function(greeting) {
        return greeting + ", " + this.name;
      }
    };
    
    user.sayHello("Hi there");
    // -> "Hi there, jcoglan"
    
    var method = user.sayHello
    //-> function()
    
    method("What the") // -> "What  the, "


!SLIDE bullets
# Object orientation

* `object.method(arg1, arg2)`
* `===`
* `object.method.call(object, arg1, arg2)`


!SLIDE bullets
# Object orientation

* `method(arg1, arg2)`
* `===`
* `method.call(window, arg1, arg2)`

