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
  users.map (user) -> "#{root}/users/#{user}/repos" # :: Stream URL
       .map (url)  -> fetch url                     # :: Stream (Promise String)
       .map (body) -> body.then JSON.parse          # :: Stream (Promise [Repo])
       .map (data) -> data.then (r) -> r.length     # :: Stream (Promise Int)

nRepos.onValue (v) -> v.then console.log
```


!SLIDE bullets

# Thank you.

- http://aanandprasad.com/articles/negronis/
- http://vimeo.com/68987289
- http://baconjs.github.io/
- http://reactive-extensions.github.io/RxJS/
