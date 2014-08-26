!SLIDE

![](underwood.png)

http://blog.jcoglan.com/2013/03/30/callbacks-are-imperative-promises-are-functional-nodes-biggest-missed-opportunity/


!SLIDE

> The nature of promises is that they remain immune to changing circumstances.

<cite>Frank Underwood, ‘House of Cards’</cite>


!SLIDE

```coffee
async.parallel [
    (callback) ->
        fs.readFile 'package.json', 'utf8', callback
    ,
    (callback) ->
        url = 'https://api.github.com/users/faye/repos'
        http.get url, callback
    ,
    (callback) ->
        db.get 'api-key', callback

], (error, [file, [response, body], key]) ->
    console.log file
    console.log JSON.parse(body)[0]
    console.log key
```


!SLIDE

```coffee
# join :: [Promise a] -> Promise [a]
join = (promises) ->
    deferred  = Q.defer()
    expecting = promises.length
    list      = []

    promises.forEach (promise, i) ->
        promise.then (value) ->
            list[i] = value
            expecting -= 1
            deferred.fulfill(list) if expecting is 0

    deferred.fulfill(list) if expecting is 0
    deferred.promise
```
