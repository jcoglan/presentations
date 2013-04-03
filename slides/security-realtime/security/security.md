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


!SLIDE bullets
# TODO

* Transport-layer security (SSL)
* Session ID generation
* Cookies: origins, staleness, server- v cookie-stored sessions
* Signing: HMAC, not hash functions
* Restricting read access (subscriptions)
* Restricting write access (publications)
* Making sure messages come from your app (CSRF)
* Safely publishing JavaScript (push-only)

