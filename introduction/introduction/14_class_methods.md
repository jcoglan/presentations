!SLIDE bullets
# Class methods

* Constructors are just functions
* Functions are objects
* We can attach methods to them
* `this` refers to the constructor


!SLIDE
# Class methods

    @@@ javascript
    Person = function(name, company) {
      this._name = name;
      this._company = company;
    };
    
    Person.fromParams = function(params) {
      params = params || {};
      var user = new this(params.username, params.company);
    };
    
    // can use:   new Person("jcoglan", "Songkick")
    //
    //      or:   Person.fromParams({
    //                username: "jcoglan",
    //                company:  "Songkick"
    //            });

