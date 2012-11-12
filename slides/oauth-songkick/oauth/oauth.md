!SLIDE title
## Everything you ever wanted to know about
# OAuth 2.0
## but were afraid to ask


!SLIDE bullets
# What is it?
* RFCs 6749 and 6750
* An authorization framework
* Not a *protocol* any more :-(
* What Facebook Connect is built on
* How our mobile apps authenticate


!SLIDE bullets
# An example
* Alice stores her photos on **fotos.com**
* She wants **printer.com** to print her photos
* OAuth lets Alice grant permission


!SLIDE title
# How does it work?


!SLIDE diagram

    +--------+                               +---------------+
    |        |--(A)- Authorization Request ->|   Resource    |
    |        |                               |     Owner     |
    |        |<-(B)-- Authorization Grant ---|               |
    |        |                               +---------------+
    |        |
    |        |                               +---------------+
    |        |--(C)-- Authorization Grant -->| Authorization |
    | Client |                               |     Server    |
    |        |<-(D)----- Access Token -------|               |
    |        |                               +---------------+
    |        |
    |        |                               +---------------+
    |        |--(E)----- Access Token ------>|    Resource   |
    |        |                               |     Server    |
    |        |<-(F)--- Protected Resource ---|               |
    +--------+                               +---------------+


!SLIDE title
## Step 0.
# Client registration


!SLIDE bullets
**printer.com** registers as a *client* with **fotos.com** (the *provider*). It
supplies:

* Its `name`
* Its `redirect_uri`, e.g. `https://printer.com/callback`
* Its `client_type` - `"confidential"` or `"public"`

It receives:

* A `client_id` - e.g. `"s6BhdRkqt3"`
* A `client_secret` - e.g. `"7Fjfp0ZBr1KtDRbnfVdmIw"`


!SLIDE title
## Step 1.
# Obtaining authorization
## `OAuth2::Provider::Authorization`


!SLIDE

    HTTP/1.1 302 Moved Temporarily
    Location: https://fotos.com/oauth/login?
              response_type=code&
              client_id=s6BhdRkqt3&
              redirect_uri=https%3A%2F%2Fprinter.com%2Fcallback&
              scope=photos%20friends_photos&
              state=xyz


!SLIDE image center
# Meanwhile on fotos.com
![](win-98-security-hack1.gif)


!SLIDE
# Success

    HTTP/1.1 302 Moved Temporarily
    Location: https://printer.com/callback?
              code=SplxlOBeZQQYbYS6WxSbIA&
              scope=photos%20friends_photos&
              state=xhz


!SLIDE
# Failure

    HTTP/1.1 302 Moved Temporarily
    Location: https://printer.com/callback?
              error=access_denied&
              error_description=The%20user%20did%20not%20grant%20you%20access&
              error_uri=http%3A%2F%2Fdocs.fotos.com%2Foauth%23access_denied&
              state=xyz


!SLIDE title
## Step 2.
# Getting an access token
## `OAuth2::Provider::Exchange`


!SLIDE

    POST /oauth/exchange HTTP/1.1
    Host: fotos.com
    Content-Type: application/x-www-form-urlencoded
    
    client_id=s6BhdRkqt3&
    client_secret=7Fjfp0ZBr1KtDRbnfVdmIw&
    redirect_uri=https%3A%2F%2Fprinter.com%2Fcallback&
    grant_type=authorization_code&
    code=SplxlOBeZQQYbYS6WxSbIA


!SLIDE

    POST /oauth/exchange HTTP/1.1
    Host: fotos.com
    Content-Type: application/x-www-form-urlencoded
    Authorization: Basic czZCaGRSa3F0Mzo3RmpmcDBaQnIxS3REUmJuZlZkbUl3
    
    redirect_uri=https%3A%2F%2Fprinter.com%2Fcallback&
    grant_type=authorization_code&
    code=SplxlOBeZQQYbYS6WxSbIA


!SLIDE

    POST /oauth/exchange HTTP/1.1
    Host: fotos.com
    Content-Type: application/x-www-form-urlencoded
    Authorization: Basic czZCaGRSa3F0Mzo3RmpmcDBaQnIxS3REUmJuZlZkbUl3
    
    redirect_uri=https%3A%2F%2Fprinter.com%2Fcallback&
    grant_type=password&
    username=alice&
    password=p455w0rd


!SLIDE

    POST /oauth/exchange HTTP/1.1
    Host: fotos.com
    Content-Type: application/x-www-form-urlencoded
    Authorization: Basic czZCaGRSa3F0Mzo3RmpmcDBaQnIxS3REUmJuZlZkbUl3
    
    redirect_uri=https%3A%2F%2Fprinter.com%2Fcallback&
    grant_type=client_credentials


!SLIDE

    POST /oauth/exchange HTTP/1.1
    Host: fotos.com
    Content-Type: application/x-www-form-urlencoded
    Authorization: Basic czZCaGRSa3F0Mzo3RmpmcDBaQnIxS3REUmJuZlZkbUl3
    
    redirect_uri=https%3A%2F%2Fprinter.com%2Fcallback&
    grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Asaml2-bearer&
    assertion=PEFzc2VydGlvbiBJc3N1ZUluc3RhbnQ9IjIwMTEtMDU


!SLIDE

    POST /oauth/exchange HTTP/1.1
    Host: fotos.com
    Content-Type: application/x-www-form-urlencoded
    Authorization: Basic czZCaGRSa3F0Mzo3RmpmcDBaQnIxS3REUmJuZlZkbUl3
    
    redirect_uri=https%3A%2F%2Fprinter.com%2Fcallback&
    grant_type=assertion&
    assertion_type=https%3A%2F%2Fgraph.facebook.com%2Fme&
    assertion=AAAAdrtydtr6r87mr6798


!SLIDE
# Success

    HTTP/1.1 200 OK
    Content-Type: application/json
    Cache-Control: no-store
    Pragma: no-cache
    
    {
      "access_token": "2YotnFZFEjr1zCsicMWpAA",
      "token_type": "example",
      "expires_in": 3600
    }


!SLIDE
# Failure

    HTTP/1.1 401 Unauthorized
    Content-Type: application/json
    Cache-Control: no-store
    Pragma: no-cache
    
    {
      "error": "unauthorized_client",
      "error_description": "The user did not grant you access",
      "error_uri": "http://docs.fotos.com/oauth#unauthorized_client"
    }


!SLIDE title
## Step 3.
# Accessing a resource
## `OAuth2::Provider::AccessToken`


!SLIDE

    GET /photos HTTP/1.1
    Host: api.fotos.com
    Authorization: Bearer 2YotnFZFEjr1zCsicMWpAA


!SLIDE

    GET /photos?access_token=2YotnFZFEjr1zCsicMWpAA HTTP/1.1
    Host: api.fotos.com
    Cache-Control: no-store


!SLIDE

    PUT /photos HTTP/1.1
    Host: api.fotos.com
    Content-Type: application/x-www-form-urlencoded
    
    access_token=2YotnFZFEjr1zCsicMWpAA


!SLIDE
# Songkick (draft 10)

    GET /photos?oauth_version=v2-10 HTTP/1.1
    Host: api.fotos.com
    Authorization: OAuth 2YotnFZFEjr1zCsicMWpAA

    GET /photos?oauth_version=v2-10&
        oauth_token=2YotnFZFEjr1zCsicMWpAA HTTP/1.1
    Host: api.fotos.com


!SLIDE
# Success

    HTTP/1.1 200 OK
    Content-Type: application/json
    Cache-Control: private
    
    {
      "photos": [
        "https://api.fotos.com/photos/1",
        "https://api.fotos.com/photos/2"
      ]
    }


!SLIDE
# Failure

    HTTP/1.1 401 Unauthorized
    WWW-Authenticate: Bearer
                      realm="fotos.com"
                      scope="photos"
                      error="invalid_token"
                      error_description="Token is expired"
                      error_uri="http://docs.fotos.com/oauth#invalid_token"


!SLIDE title
# Provider data model
## How authorization is stored


!SLIDE diagram

                              +------------------------------+
                              | OAuth2::Model::ResourceOwner |
                              +------------------------------+
                                              ^
                                              |
    +-----------------------+             +---+--+
    | OAuth2::Model::Client |             | User |
    +-------------------+---+             +---+--+
                        |                     |
                        |*                   *|
                    +---+---------------------+----+
                    | OAuth2::Model::Authorization |
                    +------------------------------+
                    | access_token_hash            |
                    | scope                        |
                    | expires_at                   |
                    +------------------------------+


!SLIDE title
# OAuth for identity
## aka the 'me' resource


!SLIDE

    GET /api/3.0/users/:me.json HTTP/1.1
    Host: api.songkick.com
    Authorization: Bearer 2YotnFZFEjr1zCsicMWpAA
    Cache-Control: no-store
    
    HTTP/1.1 200 OK
    Content-Type: application/json
    Cache-Control: private
    
    {
      "username": "jcoglan"
    }


!SLIDE bullets
# Problems
* Complicated and vague
* Many ways of doing the same thing
* Spec is bloated and terrible documentation
* Incompatible implementations
* So bad the chief editor quit in disgust


!SLIDE title
# If someone says OAuth 1.0 is hard, do not let them do programming
## Also it makes @blaine sad :-(


!SLIDE bullets
# Resources
* http://tools.ietf.org/html/draft-ietf-oauth-v2-10
* http://www.rfc-editor.org/rfc/rfc6749.txt
* http://gist.github.com/3054344

