!SLIDE

```coffee
root  = 'https://api.github.com'
stdin = process.stdin.pipe(split /\n/)

stdin.on 'data', (user) ->
    url = "#{root}/users/#{user}/repos"
    fetch(url).then (body) ->
        console.log JSON.parse(body).length
```


!SLIDE frp

```coffee
root   = 'https://api.github.com'
stdin  = process.stdin.pipe(split /\n/)

users  = bacon.fromEventTarget stdin, 'data'

nRepos =
  users.map (user) ->
      url = "#{root}/users/#{user}/repos"
      fetch(url).then (body) ->
          JSON.parse(body).length                       # Stream (Promise Int)


nRepos.onValue (v) -> v.then console.log
```


!SLIDE

```coffee
    list.map (x) -> f g(x) == list.map(g).map(f)

promise.then (x) -> f g(x) == promise.then(g).then(f)
```


!SLIDE frp

```coffee
root   = 'https://api.github.com'
stdin  = process.stdin.pipe(split /\n/)

users  = bacon.fromEventTarget stdin, 'data'

nRepos =
  users.map (user) ->
      url = "#{root}/users/#{user}/repos"
      fetch(url).then (body) ->
          JSON.parse(body).length                       # :: Stream (Promise Int)


nRepos.onValue (v) -> v.then console.log
```


!SLIDE frp

```coffee
root   = 'https://api.github.com'
stdin  = process.stdin.pipe(split /\n/)

users  = bacon.fromEventTarget stdin, 'data'

nRepos =
  users.map (user) ->
      url = "#{root}/users/#{user}/repos"
      fetch(url).then (body)  -> JSON.parse body        # :: Promise [Repo]
                .then (repos) -> repos.length           # :: Stream (Promise Int)


nRepos.onValue (v) -> v.then console.log
```


!SLIDE frp

```coffee
root   = 'https://api.github.com'
stdin  = process.stdin.pipe(split /\n/)

users  = bacon.fromEventTarget stdin, 'data'

nRepos =
  users.map (user) -> url = "#{root}/users/#{user}/repos"
                      fetch(url)                        # :: Stream (Promise String)
       .map (resp) -> resp.then (b) -> JSON.parse b     # :: Promise [Repo]
                          .then (r) -> r.length         # :: Stream (Promise Int)


nRepos.onValue (v) -> v.then console.log
```


!SLIDE frp

```coffee
root   = 'https://api.github.com'
stdin  = process.stdin.pipe(split /\n/)

users  = bacon.fromEventTarget stdin, 'data'

nRepos =
  users.map (user)  -> "#{root}/users/#{user}/repos"    # :: Stream URL
       .map (url)   -> fetch url                        # :: Stream (Promise String)
       .map (resp)  -> resp.then (b) -> JSON.parse b    # :: Stream (Promise [Repo])
       .map (repos) -> repos.then (r) -> r.length       # :: Stream (Promise Int)


nRepos.onValue (v) -> v.then console.log
```


!SLIDE frp

```coffee
root   = 'https://api.github.com'
stdin  = process.stdin.pipe(split /\n/)

users  = bacon.fromEventTarget stdin, 'data'

nRepos =
  users.map (user)  -> "#{root}/users/#{user}/repos"    # :: Stream URL
       .map (url)   -> fetch url                        # :: Stream (Promise String)
       .map bacon.fromPromise                           # :: Stream (Stream String)
       .map (resp)  -> resp.map (b) -> JSON.parse b     # :: Stream (Stream [Repo])
       .map (repos) -> repos.map (r) -> r.length        # :: Stream (Stream Int)

nRepos.onValue (v) -> v.onValue console.log
```


!SLIDE frp

```coffee
root   = 'https://api.github.com'
stdin  = process.stdin.pipe(split /\n/)

users  = bacon.fromEventTarget stdin, 'data'

nRepos =
  users.map     (user)  -> "#{root}/users/#{user}/repos"    # :: Stream URL
       .map     (url)   -> fetch url                        # :: Stream (Promise String)
       .flatMap bacon.fromPromise                           # :: Stream String
       .map     (resp)  -> JSON.parse resp                  # :: Stream [Repo]
       .map     (repos) -> repos.length                     # :: Stream Int

nRepos.onValue console.log
```


!SLIDE bullets

# Thank you.

- http://aanandprasad.com/articles/negronis/
- http://vimeo.com/68987289
- http://baconjs.github.io/
- http://reactive-extensions.github.io/RxJS/
