!SLIDE title
# Cherry-pick


!SLIDE
```
f = 1     f = 3     f = 4
g = 2     g = 2     g = 2
  o ------- o ------- o
  A        B \        C
              \
               \
                \ D        E
                 o ------- o
               f = 5     f = 5
               g = 2     g = 6
```


!SLIDE
```
f = 1     f = 3     f = 4
g = 2     g = 2     g = 2
  o ------- o ------- o ------- o
  A        B \        C         E'
              \
               \
                \ D        E
                 o ------- o
               f = 5     f = 5
               g = 2     g = 6
```


!SLIDE
```
                    f = 4
                    g = 2
                      o
                      C


                 D         E
                 o ------- o
               f = 5     f = 5
               g = 2     g = 6
```


!SLIDE
```
                    f = 4
                    g = 2
                      o
                      C         diff(D,C) = {
                                    f: [5 -> 4] }
                                }
                 D
                 o
               f = 5
               g = 2
```


!SLIDE
```




          diff(D,E) = { g: [2 -> 6] }


                 D         E
                 o ------- o
               f = 5     f = 5
               g = 2     g = 6
```


!SLIDE
```
          tree(E') = tree(D)

                   + diff(D,C)

                   + diff(D,E)
```


!SLIDE
```
          tree(E') = { f: 5, g: 2 }

                   + { f: [5 -> 4] }

                   + { g: [2 -> 6] }

                   = { f: 4, g: 6 }
```


!SLIDE
```
f = 1     f = 3     f = 4     f = 4
g = 2     g = 2     g = 2     g = 6
  o ------- o ------- o ------- o
  A        B \        C         E'
              \
               \
                \ D        E
                 o ------- o
               f = 5     f = 5
               g = 2     g = 6
```


!SLIDE
```
  A         B         C         E'
  o ------- o ------- o ------- o
             \                 /
              \               /
               \             /
                \           /
                 o ------- o
                 D         E
```


!SLIDE
```
  A         B         C         E'
  o ------- o ------- o ------- o ------- ?
             \                 /         /
              \               /         /
               \             /         /
                \           /         /
                 o ------- o ------- o
                 D         E         F
```


!SLIDE
```
                                E'
                                o
                               /
                              /
                             /
                            /
                           o ------- o
                           E         F
```


!SLIDE
```
            B         C         E'
            o ------- o ------- o
             \
              \
               \
                \
                 o ------- o ------- o
                 D         E         F
```
