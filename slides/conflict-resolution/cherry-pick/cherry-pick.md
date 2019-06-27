!SLIDE title
# Cherry-pick


!SLIDE
```
f = 1     f = 3     f = 4
g = 2     g = 2     g = 2
  A         B         C
  o <------ o <------ o
             \
              \
               \
                \
                 o <------ o
                 D         E
               f = 5     f = 5
               g = 2     g = 6
```


!SLIDE
```
f = 1     f = 3     f = 4
g = 2     g = 2     g = 2
  A         B         C         E'
  o <------ o <------ o <------ o
             \
              \
               \
                \
                 o <------ o
                 D         E
               f = 5     f = 5
               g = 2     g = 6
```


!SLIDE
```
                    f = 4
                    g = 2
                      C
                      o




                 o <------ o
                 D         E
               f = 5     f = 5
               g = 2     g = 6
```


!SLIDE
```
                    f = 4
                    g = 2
                      C
                      o

          diff(D,C) = { f: [5 -> 4] }


                 o
                 D
               f = 5
               g = 2
```


!SLIDE
```






          diff(D,E) = { g: [2 -> 6] }


                 o <------ o
                 D         E
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
  A         B         C         E'
  o <------ o <------ o <------ o
             \
              \
               \
                \
                 o <------ o
                 D         E
               f = 5     f = 5
               g = 2     g = 6
```


!SLIDE
```
  A         B         C         E'
  o <------ o <------ o <------ o
             \                 /
              \               /
               \             /
                \           /
                 o <------ o
                 D         E
```


!SLIDE
```
  A         B         C         E'
  o <------ o <------ o <------ o <------ ?
             \                 /         /
              \               /         /
               \             /         /
                \           /         /
                 o <------ o <------ o
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
                           o <------ o
                           E         F
```


!SLIDE
```
            B         C         E'
            o <------ o <------ o
             \
              \
               \
                \
                 o <------ o <------ o
                 D         E         F
```
