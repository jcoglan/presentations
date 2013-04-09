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
# TODO

* Signing: HMAC, not hash functions
* Restricting read access (subscriptions)
* Restricting write access (publications)
* Making sure messages come from your app (CSRF)
* Safely publishing JavaScript (push-only)

