!SLIDE title
# Application code

!SLIDE diagram
```
.
├── lib
│   ├── concert.coffee
│   └── concert_view.coffee
├── templates
│   └── concert.handlebars
└── vendor
    └── jquery.js
```

!SLIDE
```coffee
# lib/concert.coffee

Concert = Backbone.Model.extend()

window.Concert = Concert
```

!SLIDE
```coffee
# lib/concert_view.coffee

ConcertView = Backbone.View.extend
  initialize: ->
    @render()
    @model.on "change", => @render()

  render: ->
    t = Handlebars.templates
    html = t.concert(@model.attributes)
    @$el.html(html)

window.ConcertView = ConcertView
```

!SLIDE
```handlebars
<!-- templates/concert.handlebars -->

<div class="concert">
  <h2 class="artist">{{artist}}</h2>
  <h3 class="venue">
    {{venueName}}, {{cityName}}, {{country}}
  </h3>
</div>
```

!SLIDE title
# Tests

!SLIDE diagram
```
.
├── lib
│   ├── concert.coffee
│   └── concert_view.coffee
├── spec
│   ├── concert_template_spec.coffee
│   ├── concert_view_spec.coffee
├── templates
│   └── concert.handlebars
└── vendor
    └── jquery.js
```

!SLIDE test
```coffee
# spec/concert_template_spec.coffee

JS.Test.describe "templates.concert()", ->
  @before ->
    @concert =
      artist:    "Boredoms",
      venueName: "The Forum",
      cityName:  "Kentish Town",
      country:   "UK"

    @html = $(Handlebars.templates.concert(@concert))

  @it "renders the artist name", ->
    @assertEqual "Boredoms", @html.find(".artist").text().trim()

  @it "renders the venue details", ->
    @assertEqual "The Forum, Kentish Town, UK",
                 @html.find(".venue").text().trim()
```

!SLIDE test
```coffee
# spec/concert_view_spec.coffee

JS.Test.describe "ConcertView", ->
  @before ->
    @fixture = $(".fixture").html('<div class="concert"></div>')

    @concert = new Concert
      artist:    "Boredoms",
      venueName: "The Forum",
      cityName:  "Kentish Town",
      country:   "UK"

    new ConcertView
      el:    @fixture.find(".concert"),
      model: @concert

  @it "renders the artist name", ->
    @assertEqual "Boredoms", @fixture.find(".artist").text().trim()

  @it "updates the artist name if it changes", ->
    @concert.set "artist", "Low"
    @assertEqual "Low", @fixture.find(".artist").text().trim()
```

!SLIDE title
# Dependencies

!SLIDE diagram
```
.
├── lib
│   ├── concert.coffee
│   └── concert_view.coffee
├── package.json
├── spec
│   ├── concert_template_spec.coffee
│   ├── concert_view_spec.coffee
├── templates
│   └── concert.handlebars
└── vendor
    └── jquery.js
```

!SLIDE
```json
{
  "dependencies": {
    "backbone":      "~1.1.0",
    "underscore":    "~1.5.0"
  },

  "devDependencies": {
    "coffee-script": "~1.7.0",
    "handlebars":    "~1.3.0",
    "jstest":        "~1.0.0",
    "uglify-js":     "~2.4.0"
  }
}
```

!SLIDE diagram
```
node_modules/.bin/
├── cake -> ../coffee-script/bin/cake
├── coffee -> ../coffee-script/bin/coffee
├── handlebars -> ../handlebars/bin/handlebars
├── jstest -> ../jstest/bin/jstest
└── uglifyjs -> ../uglify-js/bin/uglifyjs
```

!SLIDE title
# Make basics

!SLIDE
```





  a.txt: b.txt c.txt
          echo "Building a.txt"
          cat b.txt c.txt > a.txt





```

!SLIDE
```
 target
    |
    |
  /-+-\

  a.txt: b.txt c.txt
          echo "Building a.txt"
          cat b.txt c.txt > a.txt





```

!SLIDE
```
 target   dependencies
    |         |
    |         |
  /-+-\  /----+----\

  a.txt: b.txt c.txt
          echo "Building a.txt"
          cat b.txt c.txt > a.txt





```

!SLIDE
```
 target   dependencies
    |         |
    |         |
  /-+-\  /----+----\

  a.txt: b.txt c.txt
          echo "Building a.txt"     <-+-- recipe
          cat b.txt c.txt > a.txt   <-+





```

!SLIDE
```
 target   dependencies
    |         |
    |         |
  /-+-\  /----+----\

  a.txt: b.txt c.txt
          echo "Building a.txt"     <-+-- recipe
          cat b.txt c.txt > a.txt   <-+

  \--+---/
     |
     |
    tab
```

!SLIDE
```
# ~/.vimrc

autocmd filetype make setlocal noexpandtab
```
