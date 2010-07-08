!SLIDE bullets
# Control flow

* All the usual Java control statements
* `if` / `else`
* `switch`
* `for` and `for in`
* `while`
* `try` / `catch` / `finally`


!SLIDE
# `if` / `else`

    @@@ javascript
    // can have a single statement
    if (expression) doSomething();
    
    // or a block
    if (expression) {
      doSomething();
      doSomethingElse();
    }
    
    // else is optional
    if (expression) {
      foo();
    } else {
      bar();
    }


!SLIDE
# `switch`

    @@@ javascript
    // * takes any expression and a bunch of cases
    // * case values can be any expression
    // * cases fall through unless you break
    
    switch (expression) {
      case "foo":
        doFoo();
        break;
      
      case "bar":
        doBar();
        break;
      
      default:
        doDefault();
    }


!SLIDE
# `for` and `for in`

    @@@ javascript
    // standard for loop
    for (var i = 0, n = images.length; i < n; i += 1) {
      displayImage(images[i]);
    }
    
    // for-in loop
    for (var key in object) {
      console.log(key);
    }
    
    // careful with inherited properties
    for (var key in object) {
      if (!object.hasOwnProperty(key)) continue;
      // ...
    }
    
    // some libraries have iterator methods
    jQuery.each(images, function(i, image) {
      displayImage(image);
    });


!SLIDE
# `while`

    @@@ javascript
    // checks the expression /before/ each iteration
    
    while (expression) {
      // ...
    }
    
    // checks the expression /after/ each iteration
    do {
      // ...
    } while (expression)


!SLIDE
# `try` / `catch` / `finally`

    @@@ javascript
    // Runs the `try` block. If an exception is thrown
    // then runs the `catch` block. The `finally` block
    // is run either way.
    
    try {
      throw new Error("omg fail!!!");
    } catch (e) {
      console.log(e.message);
    } finally {
      alert("And we're done");
    }

