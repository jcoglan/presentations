!SLIDE title
## Proof by
# Mathematical induction


!SLIDE math
    sum (1 .. 1)    =   1

    sum (1 .. 2)    =   3

    sum (1 .. 3)    =   6

    sum (1 .. 4)    =   10


!SLIDE math
                        n (n + 1)
    sum (1 .. n)    =   ---------
                            2


!SLIDE math
    1     2     3     4     5     6     7     8     9     10


!SLIDE math
       1     2     3     4     5     6     7     8     9
       10


!SLIDE math
          1     2     3     4     5     6     7     8
          10    9


!SLIDE math
             1     2     3     4     5     6     7
             10    9     8


!SLIDE math
                1     2     3     4     5     6
                10    9     8     7


!SLIDE math
                   1     2     3     4     5
                   10    9     8     7     6


!SLIDE math
    sum (1 .. n+1)  =   sum (1 .. n) + (n + 1)


!SLIDE math
                        n (n + 1)
    sum (1 .. n+1)  =   --------- + (n + 1)
                            2


!SLIDE math
                        n^2 + n
    sum (1 .. n+1)  =   ------- + (n + 1)
                           2


!SLIDE math
                        n^2 + n   2n + 2
    sum (1 .. n+1)  =   ------- + ------
                           2         2


!SLIDE math
                        n^2 + n + 2n + 2
    sum (1 .. n+1)  =   ----------------
                                2


!SLIDE math
                        n^2 + 3n + 2
    sum (1 .. n+1)  =   ------------
                              2


!SLIDE math
                        (n + 1) (n + 2)
    sum (1 .. n+1)  =   ---------------
                               2


!SLIDE math
                        (n + 1) ((n + 1) + 1)
    sum (1 .. n+1)  =   ---------------------
                                  2


!SLIDE math
                        n (n + 1)
    sum (1 .. n)    =   ---------
                            2


                        (n + 1) ((n + 1) + 1)
    sum (1 .. n+1)  =   ---------------------
                                  2


!SLIDE title
## Proof by
# Structural induction


!SLIDE bullets subhead

A list of `a` is either:

* the empty list, or
* an `a` paired with a list of `a`.


!SLIDE code

```hs
data [a] = [] | a : [a]
```


!SLIDE code

```hs
[1, 2, 3, 4]  ==  (1 : (2 : (3 : (4 : []))))
```


!SLIDE diagram

                      .
                     / \
                    1   .
                       / \
                      2   .
                         / \
                        3   .
                           / \
                          4   []


!SLIDE code

```js
function length(list) {
  let n = 0
  for (let item of list) {
    n += 1
  }
  return n
}

function map(f, list) {
  let result = []
  for (let item of list) {
    result.push(f(item))
  }
  return result
}
```


!SLIDE code

```hs
length        :: [a] -> Int
length []     =  0
length (x:xs) =  1 + length xs

map           :: (a -> b) -> [a] -> [b]
map f []      =  []
map f (x:xs)  =  f x : map f xs
```


!SLIDE title subhead
# Functor composition law


!SLIDE code

```hs
(.)       :: (b -> c) -> (a -> b) -> a -> c
(f . g) x =  f (g x)
```


!SLIDE code
```hs
map f (map g list)  ==  map (f . g) list
```


!SLIDE code
```hs
map f (map g (x : list))










```

!SLIDE code
```hs
map f (map g (x : list))

    ==  map f (g x : map g list)








```

!SLIDE code
```hs
map f (map g (x : list))

    ==  map f (g x : map g list)

    ==  f (g x) : map f (map g list)






```

!SLIDE code
```hs
map f (map g (x : list))

    ==  map f (g x : map g list)

    ==  f (g x) : map f (map g list)

    ==  f (g x) : map (f . g) list




```

!SLIDE code
```hs
map f (map g (x : list))

    ==  map f (g x : map g list)

    ==  f (g x) : map f (map g list)

    ==  f (g x) : map (f . g) list

    ==  (f . g) x : map (f . g) list


```

!SLIDE code
```hs
map f (map g (x : list))

    ==  map f (g x : map g list)

    ==  f (g x) : map f (map g list)

    ==  f (g x) : map (f . g) list

    ==  (f . g) x : map (f . g) list

    ==  map (f . g) (x : list)
```
