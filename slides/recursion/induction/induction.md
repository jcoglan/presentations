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


!SLIDE bullets

A list of `a` is either:

* the empty list, or
* an `a` paired with a list of `a`.

```hs
data [a] = [] | a : [a]
```


!SLIDE

```hs
[1, 2, 3, 4]  ==  (1 : (2 : (3 : (4 : []))))
```


!SLIDE

```hs
length        :: [a] -> Int
length []     =  0
length (x:xs) =  1 + length xs

map          :: (a -> b) -> [a] -> [b]
map f []     =  []
map f (x:xs) =  f x : map f xs
```


!SLIDE
```hs
length (map f list)  ==  length list
```


!SLIDE
```hs
length (map f (x : list))

    

    

    

    
```


!SLIDE
```hs
length (map f (x : list))

    ==  length (f x : map f list)

    

    

    
```


!SLIDE
```hs
length (map f (x : list))

    ==  length (f x : map f list)

    ==  1 + length (map f list)

    

    
```


!SLIDE
```hs
length (map f (x : list))

    ==  length (f x : map f list)

    ==  1 + length (map f list)

    ==  1 + length list

    
```


!SLIDE
```hs
length (map f (x : list))

    ==  length (f x : map f list)

    ==  1 + length (map f list)

    ==  1 + length list

    ==  length (x : list)
```


!SLIDE title
## One more example
# Composed maps


!SLIDE

```hs
(.)       :: (b -> c) -> (a -> b) -> a -> c
(f . g) h =  f (g h)
```


!SLIDE
```hs
map f (map g list)  ==  map (f . g) list
```


!SLIDE
```hs
map f (map g (x : list))

    

    

    

    

    
```

!SLIDE
```hs
map f (map g (x : list))

    ==  map f (g x : map g list)

    

    

    

    
```

!SLIDE
```hs
map f (map g (x : list))

    ==  map f (g x : map g list)

    ==  f (g x) : map f (map g list)

    

    

    
```

!SLIDE
```hs
map f (map g (x : list))

    ==  map f (g x : map g list)

    ==  f (g x) : map f (map g list)

    ==  f (g x) : map (f . g) list

    

    
```

!SLIDE
```hs
map f (map g (x : list))

    ==  map f (g x : map g list)

    ==  f (g x) : map f (map g list)

    ==  f (g x) : map (f . g) list

    ==  (f . g) x : map (f . g) list

    
```

!SLIDE
```hs
map f (map g (x : list))

    ==  map f (g x : map g list)

    ==  f (g x) : map f (map g list)

    ==  f (g x) : map (f . g) list

    ==  (f . g) x : map (f . g) list

    ==  map (f . g) (x : list)
```
