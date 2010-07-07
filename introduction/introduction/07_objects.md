!SLIDE bullets
# Objects

* Objects are just hashtables
* Created with `{}` or `new Object()`
* The keys are strings
* You can add any property to any object
* Inheritance is prototypal


!SLIDE
# Objects

    @@@ javascript
    // object literal
    user = {"name": "jcoglan", "company": "Songkick"};
    
    // read by key
    user["name"] // -> "jcoglan"
    user["what"] // -> undefined
    
    // assign by key
    user["city"] = "London";
    
    // keys can be any string
    user["the meaning of life"] = 42;
    
    // values can be any JavaScript value
    user["trackings"] = ["Boredoms", "GY!BE"]
    
    // if the key's a valid variable name, use dot notation
    user = {name: "jcoglan", company: "Songkick"};
    user.name // -> "jcoglan"
    user.city = "London";

