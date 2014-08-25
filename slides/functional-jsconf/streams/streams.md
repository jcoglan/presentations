!SLIDE

```coffee
stream = require 'stream'

class Map extends stream.Transform
    constructor: (f) ->
        stream.Transform.call @, streamOpts
        @_f = f

    _transform: (chunk, encoding, callback) ->
        @push @_f(chunk, encoding)
        callback()

# map :: Stream a -> (a -> b) -> Stream b
stream.prototype.map = (f) ->
    @pipe new Map(f)
```


!SLIDE

```coffee
stream = require 'stream'

class Filter extends stream.Transform
    constructor: (p) ->
        stream.Transform.call @, streamOpts
        @_p = p

    _transform: (chunk, encoding, callback) ->
        @push chunk if @_p(chunk, encoding)
        callback()

# filter :: Stream a -> (a -> Bool) -> Stream a
stream.prototype.filter = (p) ->
    @pipe new Filter(p)
```


!SLIDE

```coffee
stream = require 'stream'

class Take extends stream.Transform
    constructor: (n) ->
        stream.Transform.call @, streamOpts
        @_n = n

    _transform: (chunk, encoding, callback) ->
        @push chunk if @_n > 0
        @_n -= 1
        @end() if @_n is 0
        callback()

# take :: Stream a -> Int -> Stream a
stream.prototype.take = (n) ->
    @pipe new Take(n)
```


!SLIDE

```coffee
split = require 'split'

stream.prototype.split = (pattern) ->
    @pipe split(pattern)
```


!SLIDE

```coffee
streamOpts = { highWaterMark: 0 }
```


!SLIDE

```coffee
fs = require 'fs'
f  = fs.createReadStream 'lazy.coffee'

classes = f.split  /\n/
           .filter (line) -> line.match /^class /
           .map    (line) -> line.toUpperCase()
           .take   1

classes.on 'data', console.log

# Output:
#
# CLASS MAP EXTENDS STREAM.TRANSFORM
```
