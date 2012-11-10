!SLIDE bullets
# We abstracted shared logic into web services
* Split along domain boundaries
* Encapsulate data stores and business logic
* APIs designed around use cases


!SLIDE title
# ActiveRecord APIs reflect database schemas


!SLIDE title
# Service APIs reflect clients’ common use cases


!SLIDE title
# An object graph != an API


!SLIDE bullets
# For a concert, we want:
* The date
* The venue, its city and country
* The artists performing and their billing


!SLIDE listing
# An object-based API

    $ curl http://service/concerts/123
    {
      "date": "20121008T19:30:00Z",
      "links": {
        "venue": "http://service/venues/456",
        "performances": [
          "http://service/performances/789",
          "http://service/performances/123"
        ]
      }
    }


!SLIDE listing
# A use-case-based API

    $ curl http://service/concerts/123
    {
      "date": "20121008T19:30:00Z",
      "venue": {
        "name": "Brixton Academy",
        "city": {
          "name": "London",
          "country" {"name": "UK"}
        }
      },
      "artists": [
        {"name": "Radiohead", "billing": "headline"},
        {"name": "Caribou",   "billing": "support"}
      ]
    }


!SLIDE quote

> Remember that the job of your model layer is not to represent objects but to
> answer questions. Provide an API that answers the questions your application
> has, as simply and efficiently as possible.

http://seldo.com/weblog/2011/08/11/orm\_is\_an\_antipattern/


!SLIDE bullets
# Result:
* An explicit stable API layer
* Decouples app processes from ActiveRecord and more
* Can begin splitting business logic up
* Can begin splitting data store up

