!SLIDE title
## Rule 0 of web applications:
# Anyone can send you any bytes at any time via TCP


!SLIDE title
# Layered validation
## A cleanly separated stack is easier to reason about


!SLIDE diagram

    +--------------------+
    |    Node HTTP lib   |      * Handles HTTP
    +----------+---------+      * Provides request, response objects
               |
               V
    +--------------------+      * Handles WebSocket, EventSource
    |  Faye.NodeAdapter  |      * Extracts messages from requests/sockets
    +----------+---------+      * Provides Bayeux message objects
               |                * Sends response messages out
               V
    +--------------------+
    | Faye.BayeuxHandler |      * Handles Bayeux messages
    +----------+---------+      * Generates response messages
               |
               V
    +--------------------+      * Executes business logic
    |     Faye.Engine    |      * Stores subscriptions
    +--------------------+      * Routes messages


!SLIDE title
# Securing the transport layer
## SSL, cookies and origins


!SLIDE bullets
# Deploy SSL

* Use your platform’s SSL library
* Deploy with STunnel in front of your server
* Connect over `wss:` and `https:`


!SLIDE bullets
# Protects against

* Eavesdropping by other network users
* In-flight message modification
* XSS via JSON-P to unverified hosts


!SLIDE title
# Cookies
## Not as great as they sound


!SLIDE diagram

       +--------------------+           +-------------------+
       | http://example.com |           | http://hacker.com |
       +---------+----------+           +-------------------+
                 |
                 |
    +------------+------------+
    | POST /session HTTP/1.1  |
    | Host: example.com       |
    | Origin: example.com     |
    +------------+------------+
                 |
                 V
            +--------+
            | Server |
            +--------+


!SLIDE diagram

       +--------------------+           +-------------------+
       | http://example.com |           | http://hacker.com |
       +--------------------+           +-------------------+
                 ^
                 |
    +------------+------------+
    | Set-Cookie: sessid=abc; |
    |     Domain=example.com; |
    |     Path=/              |
    +------------+------------+
                 |
                 |
            +----+---+
            | Server |
            +--------+


!SLIDE diagram

       +--------------------+           +-------------------+
       | http://example.com |           | http://hacker.com |
       +--------------------+           +-------------------+
                                             /\
                       +--------------------'  `------------+
                       | new WebSocket('ws://example.com/') |
                       +------------------------------------+





            +--------+
            | Server |
            +--------+


!SLIDE diagram

       +--------------------+           +-------------------+
       | http://example.com |           | http://hacker.com |
       +--------------------+           +-------------------+
                                          /
                    +--------------------+
                    | GET / HTTP/1.1     |
                    | Host: example.com  |
                    | Origin: hacker.com |
                    | Upgrade: websocket |
                    | Cookie: sessid=abc |
                    +--------------------+
                   /
            +--------+
            | Server |
            +--------+


!SLIDE bullets
# At best, cookies prevent

* Unauthorized data access
* Execution of commands from untrusted parties


!SLIDE bullets
# If you *must* use cookies

* Check the `Origin` header
* Set the `HttpOnly` flag
* Set the `Secure` flag and connect over `wss:`
* Never authenticate CORS resources with cookies
* Use server-stored (not cookie-stored) sessions
* Generate large (> 160 bits) session IDs


!SLIDE bullets
# However…

* `Origin` can be guessed easily
* Browser extensions/hacks can spoof it
* Non-browser clients can send what they like
* Cookies only sent on first connection
* They enable CSRF


!SLIDE bullets
# Securing the protocol
## Moving above the transport layer


!SLIDE

    @@@javascript
    {
      "channel":      "/meta/subscribe",
      "clientId":     "79o6pn01muyqn1t5gkte0zy",
      "subscription": "/messages",
      "ext": {
        "userId":     18787,
        "token":      "340256c4276b2d3483f02fe"
      }
    }


!SLIDE

    @@@javascript
    client.addExtension({
      outgoing: function(message, callback) {
        if (message.channel === '/meta/subscribe') {
          message.ext = message.ext || {};
          message.ext.userId = 18787;
          message.ext.token = '340256c4276b2...';
        }
        callback(message);
      }
    });


!SLIDE

    @@@javascript
    server.addExtension({
      incoming: function(message, callback) {
        if (message.channel === '/meta/subscribe') {
          var sub    = message.subscription,
              ext    = message.ext,
              userId = ext.userId,
              token  = ext.token;
          
          if (!valid(sub, userId, token))
            message.error = '403::Forbidden';
        }
        callback(message);
      }
    });


!SLIDE title
# Generating tokens
## Use HMAC, *not* hash functions


!SLIDE

    @@@javascript
    var c     = require('crypto'),
        hmac  = c.createHmac('sha256', 'secret'),
        tag   = hmac.update('the user ID'),
        token = tag.digest('hex');

    // token = '340256c4276b2...'


!SLIDE bullets
# Protects against

* Unauthorized access to publish/subscribe
* Fraudulent requests sent from other sites


!SLIDE title
# Publishing JavaScript
## *Please* don’t do this


!SLIDE

    @@@javascript
    client.subscribe('/commands', function(msg) {
      eval(msg.payload);
    });


!SLIDE bullets
# Problems

* You can’t validate JavaScript for safety
* How do we trust the code came from our app?


!SLIDE title
# Push-only servers
## Require a password for publishing


!SLIDE

    @@@JavaScript
    server.addExtension({
      incoming: function(message, callback) {
        if (!/^\/meta\//.test(message.channel)) {
          var pass = message.ext.password;
          if (pass !== 'magic words')
            message.error = '403::Forbidden';
        }
        callback(message);
      }
    });


!SLIDE

    @@@javascript
    server.addExtension({
      outgoing: function(message, callback) {
        if (message.ext)
          delete message.ext.password;

        callback(message);
      }
    });


!SLIDE

    @@@javascript
    client.addExtension({
      outgoing: function(message, callback) {
        message.ext = message.ext || {};
        message.ext.password = 'magic words';
        callback(message);
      }
    });
