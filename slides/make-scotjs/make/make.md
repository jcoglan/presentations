!SLIDE title
# Templates

!SLIDE diagram
```
.
├── Makefile
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

!SLIDE diagram
```
.
├── Makefile
├── build
│   └── templates.js <-------------------------+
├── lib                                        |
│   ├── concert.coffee                         |
│   └── concert_view.coffee                    |
├── package.json                               |
├── spec                                       |
│   ├── concert_template_spec.coffee           |
│   ├── concert_view_spec.coffee               |
├── templates                                  |
│   └── concert.handlebars O-------------------+
└── vendor
    └── jquery.js
```

!SLIDE make
```make
PATH  := node_modules/.bin:$(PATH)
SHELL := /bin/bash

build/templates.js: templates/*.handlebars
    mkdir -p $(dir $@)
    handlebars templates/*.handlebars > $@
```

!SLIDE sigil
```
$@
```

!SLIDE sigil
```
$(dir $@)
```

!SLIDE make
```make
PATH  := node_modules/.bin:$(PATH)
SHELL := /bin/bash

template_source := templates/*.handlebars
template_js     := build/templates.js

$(template_js): $(templates_source)
    mkdir -p $(dir $@)
    handlebars $(templates_source) > $@
```

!SLIDE
```
$ touch templates/concert.handlebars 

$ make
mkdir -p build/
handlebars templates/*.handlebars > build/templates.js

$ make
make: `build/templates.js' is up to date.
```

!SLIDE title
# CoffeeScript

!SLIDE diagram
```
.
├── Makefile
├── build
│   └── templates.js
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

!SLIDE diagram
```
.
├── Makefile
├── build
│   ├── lib
│   │   ├── concert.js
│   │   └── concert_view.js
│   ├── spec
│   │   ├── concert_template_spec.js
│   │   └── concert_view_spec.js
│   └── templates.js
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

!SLIDE diagram
```
.
├── Makefile
├── build
│   ├── lib
│   │   ├── concert.js <-----------------------+
│   │   └── concert_view.js                    |
│   ├── spec                                   |
│   │   ├── concert_template_spec.js           |
│   │   └── concert_view_spec.js               |
│   └── templates.js                           |
├── lib                                        |
│   ├── concert.coffee O-----------------------+
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

!SLIDE diagram
```
.
├── Makefile
├── build
│   ├── lib
│   │   ├── concert.js
│   │   └── concert_view.js <------------------+
│   ├── spec                                   |
│   │   ├── concert_template_spec.js           |
│   │   └── concert_view_spec.js               |
│   └── templates.js                           |
├── lib                                        |
│   ├── concert.coffee                         |
│   └── concert_view.coffee O------------------+
├── package.json
├── spec
│   ├── concert_template_spec.coffee
│   ├── concert_view_spec.coffee
├── templates
│   └── concert.handlebars
└── vendor
    └── jquery.js
```

!SLIDE diagram
```
.
├── Makefile
├── build
│   ├── lib
│   │   ├── concert.js
│   │   └── concert_view.js
│   ├── spec
│   │   ├── concert_template_spec.js <---------+
│   │   └── concert_view_spec.js               |
│   └── templates.js                           |
├── lib                                        |
│   ├── concert.coffee                         |
│   └── concert_view.coffee                    |
├── package.json                               |
├── spec                                       |
│   ├── concert_template_spec.coffee O---------+
│   ├── concert_view_spec.coffee
├── templates
│   └── concert.handlebars
└── vendor
    └── jquery.js
```

!SLIDE diagram
```
.
├── Makefile
├── build
│   ├── lib
│   │   ├── concert.js
│   │   └── concert_view.js
│   ├── spec
│   │   ├── concert_template_spec.js
│   │   └── concert_view_spec.js <-------------+
│   └── templates.js                           |
├── lib                                        |
│   ├── concert.coffee                         |
│   └── concert_view.coffee                    |
├── package.json                               |
├── spec                                       |
│   ├── concert_template_spec.coffee           |
│   ├── concert_view_spec.coffee O-------------+
├── templates
│   └── concert.handlebars
└── vendor
    └── jquery.js
```

!SLIDE diagram
```
.
├── Makefile
├── build
│   ├── lib
│   │   ├── concert.js <-----------------------+
│   │   └── concert_view.js <------------------+
│   ├── spec                                   |
│   │   ├── concert_template_spec.js <---------+
│   │   └── concert_view_spec.js <-------------+
│   └── templates.js                           |
├── lib                                        |
│   ├── concert.coffee O-----------------------+
│   └── concert_view.coffee O------------------+
├── package.json                               |
├── spec                                       |
│   ├── concert_template_spec.coffee O---------+
│   ├── concert_view_spec.coffee O-------------+
├── templates
│   └── concert.handlebars
└── vendor
    └── jquery.js
```

!SLIDE make
```make
build/%.js: %.coffee
    coffee -co $(dir $@) $<

# e.g.
# 
# $ make build/lib/concert.js
# coffee -co build/lib/ lib/concert.coffee
```

!SLIDE sigil
```
$<
```

!SLIDE title
# Minification

!SLIDE diagram
```
.
├── Makefile
├── build
│   ├── lib
│   │   ├── concert.js
│   │   └── concert_view.js
│   ├── spec
│   │   ├── concert_template_spec.js
│   │   └── concert_view_spec.js
│   └── templates.js
├── lib
│   ├── concert.coffee
│   └── concert_view.coffee
├── node_modules
│   ├── ...
├── package.json
├── spec
│   ├── concert_template_spec.coffee
│   ├── concert_view_spec.coffee
├── templates
│   └── concert.handlebars
└── vendor
    └── jquery.js
```

!SLIDE diagram
```
.
├── Makefile
├── build
│   ├── app.js <-------------------------------+
│   ├── lib                                    |
│   │   ├── concert.js O-----------------------+
│   │   └── concert_view.js O------------------+
│   ├── spec                                   |
│   │   ├── concert_template_spec.js           |
│   │   └── concert_view_spec.js               |
│   └── templates.js O-------------------------+
├── lib                                        |
│   ├── concert.coffee                         |
│   └── concert_view.coffee                    |
├── node_modules                               |
│   ├── ... O----------------------------------+
├── package.json                               |
├── spec                                       |
│   ├── concert_template_spec.coffee           |
│   ├── concert_view_spec.coffee               |
├── templates                                  |
│   └── concert.handlebars                     |
└── vendor                                     |
    └── jquery.js O----------------------------+
```

!SLIDE make
```make
# WRONG!

build/app.js: build/lib/*.js build/templates.js
```

!SLIDE make
```make
source_files := $(wildcard lib/*.coffee)

# -> lib/concert.coffee lib/concert_view.coffee
```

!SLIDE make
```make
build_files := $(source_files:%.coffee=build/%.js)

# -> build/lib/concert.js build/lib/concert_view.js
```

!SLIDE make
```make
source_files := $(wildcard lib/*.coffee)
build_files  := $(source_files:%.coffee=build/%.js)

spec_coffee  := $(wildcard spec/*.coffee)
spec_js      := $(spec_coffee:%.coffee=build/%.js)

build/%.js: %.coffee
    coffee -co $(dir $@) $<
```

!SLIDE make
```make
app_bundle := build/app.js

libs := vendor/jquery.js \
    node_modules/handlebars/dist/handlebars.runtime.js \
    node_modules/underscore/underscore.js \
    node_modules/backbone/backbone.js

$(app_bundle): $(libs) $(build_files) $(template_js)
    uglifyjs -cmo $@ $^
```
!SLIDE make
```make
app_bundle := build/app.js

libs := vendor/jquery.js \
    node_modules/handlebars/dist/handlebars.runtime.js \
    node_modules/underscore/underscore.js \
    node_modules/backbone/backbone.js

.PHONY: all

all: $(app_bundle)

$(app_bundle): $(libs) $(build_files) $(template_js)
    uglifyjs -cmo $@ $^
```

!SLIDE sigil
```
$^
```

!SLIDE title
# Browserify

!SLIDE
```js
// pizza.js
var dough = require('./components/dough');

// components/dough.js
var flour = require('../ingredients/flour');

// ingredients/flour.js
module.exports = { ... };
```

!SLIDE make
```make
# WRONG!

dinner.js: pizza.js
    browserify $< > $@
```

!SLIDE
```
$ make
browserify pizza.js > dinner.js

$ touch ingredients/flour.js

$ make
make: `dinner.js' is up to date.
```

!SLIDE
```
$ browserify --list pizza.js
pizza.js
components/dough.js
ingredients/flour.js
```

!SLIDE make
``` make
app_root := pizza.js

dinner.js: $(shell browserify --list $(app_root))
    browserify $(app_root) > $@
```

!SLIDE
```
$ make
browserify pizza.js > dinner.js

$ touch ingredients/flour.js

$ make
browserify pizza.js > dinner.js

$ make
make: `dinner.js' is up to date.
```

!SLIDE title
# Running tests

!SLIDE html
```html
<!-- spec/test.html -->

<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title>jstest</title>
  </head>
  <body>

    <div class="fixture"></div>

    <script src="../build/app.js"></script>
    <script src="../node_modules/jstest/jstest.js"></script>
    <script src="../build/spec/concert_template_spec.js"></script>
    <script src="../build/spec/concert_view_spec.js"></script>

    <script>
      JS.Test.autorun()
    </script>

  </body>
</html>
```

!SLIDE
```js
// spec/phantom.js

var JS = require('../node_modules/jstest/jstest')

var reporter = new JS.Test.Reporters.Headless({})
reporter.open('spec/test.html')
```

!SLIDE make
```make
test: $(app_bundle) $(spec_js)
    phantomjs spec/phantom.js
```

!SLIDE make
``` make
clean:
    rm -rf build
```

!SLIDE make
```make
.PHONY: all clean test
```

!SLIDE diagram
```
$ make clean
rm -rf build

$ make test
coffee -co build/lib/ lib/concert.coffee
coffee -co build/lib/ lib/concert_view.coffee
mkdir -p build/
handlebars templates/*.handlebars > build/templates.js
uglifyjs -cmo build/app.js vendor/jquery.js ...
coffee -co build/spec/ spec/concert_template_spec.coffee
coffee -co build/spec/ spec/concert_view_spec.coffee
phantomjs spec/phantom.js
Loaded suite: templates.concert(), ConcertView

....

Finished in 0.041 seconds
4 tests, 4 assertions, 0 failures, 0 errors
```

!SLIDE diagram
```
$ make test
phantomjs spec/phantom.js
Loaded suite: templates.concert(), ConcertView

....

Finished in 0.038 seconds
4 tests, 4 assertions, 0 failures, 0 errors
```

!SLIDE
# Grunt
```
    handlebars    coffee    uglify    test
        |           |          |        |
        +-----------+----+-----+--------+
                         |
                         |
                       build
```

!SLIDE
# Make
```
           handlebars      coffee
               |              |
               +-------+------+
                       |
                       |
                    uglify
                       |
                       |
                     test
```
