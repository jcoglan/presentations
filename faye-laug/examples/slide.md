!SLIDE center
# Example

When I click a link, the user should see the Facebook
Connect login dialog. Once they sign in, we should
store their details and log the event with Analytics.


!SLIDE
# Example

    @@@ javascript
    $('a.facebook-connect').bind('click', function() {
      FB.login(function(response) {
        if (!response.session) return;
        FB.api('/me', function(userData) {
          $.post('/sessions/new', userData, function() {
            pageTracker._trackPageview('/logins/facebook');
          });
        });
      });
      return false;
    });


!SLIDE
## 1. Separate DOM from business logic

    @@@ javascript
    Facebook = {
      connect: function() {
        FB.login(function(response) {
          if (!response.session) return;
          FB.api('/me', function(userData) {
            $.post('/sessions/new', userData, function() {
              pageTracker._trackPageview('/logins/facebook');
            });
          });
        });
      }
    };
    
    $('a.facebook-connect').bind('click', function() {
      Facebook.connect();
      return false;
    });


!SLIDE
## 2. Defer actions until login

    @@@ javascript
    Facebook = {
      connect: function() {
        this.login(this.authenticate, this);
      },
      
      authenticate: function() {
        FB.api('/me', function(userData) {
          $.post('/sessions/new', userData, function() {
            pageTracker._trackPageview('/logins/facebook');
          });
        });
      }
    };


!SLIDE
## 2. Defer actions until login

    @@@ javascript
    $.extend(Facebook, Deferrable);
    
    Facebook.login = function(callback, scope) {
      this.addCallback(callback, scope);
      FB.login(function(response) {
        if (response.session)
          Facebook.succeed();
      });
    };
    
    $('a.facebook-connect').bind('click', function() {
      Facebook.connect();
      return false;
    });


!SLIDE
## 3. Separate logging with events

    @@@ javascript
    $.extend(Facebook, Observable);
    
    Facebook.authenticate = function() {
      FB.api('/me', function(userData) {
        $.post('/sessions/new', userData, function() {
          Facebook.publishEvent('signin');
        });
      });
    };
    
    Facebook.addListener('signin', function() {
      pageTracker._trackPageview('/logins/facebook');
    });
