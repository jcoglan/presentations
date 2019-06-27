!SLIDE title
# A chain of commits


!SLIDE
```
f = 1
g = 1
h = 1
  A
  o









```


!SLIDE
```
f = 1     f = 2
g = 1     g = 3
h = 1     h = 1
  A         B
  o <------ o









```


!SLIDE
```
f = 1     f = 2     f = 4
g = 1     g = 3     g = 3
h = 1     h = 1     h = 1
  A         B         C
  o <------ o <------ o









```


!SLIDE
```
f = 1     f = 2     f = 4
g = 1     g = 3     g = 3
h = 1     h = 1     h = 1
  A         B         C
  o <------ o <------ o
             \
              \
               \
                \
                 o
                 D
               f = 2
               g = 5
               h = 1
```


!SLIDE
```
f = 1     f = 2     f = 4
g = 1     g = 3     g = 3
h = 1     h = 1     h = 1
  A         B         C
  o <------ o <------ o
             \
              \
               \
                \
                 o <------ o
                 D         E
               f = 2     f = 2
               g = 5     g = 5
               h = 1     h = 6
```


!SLIDE
```
f = 1     f = 2     f = 4
g = 1     g = 3     g = 3
h = 1     h = 1     h = 1
  A         B         C
  o <------ o <------ o <------ ?
             \                 /
              \               /
               \             /
                \           /
                 o <------ o
                 D         E
               f = 2     f = 2
               g = 5     g = 5
               h = 1     h = 6
```


!SLIDE
```
f = 1     f = 2     f = 4     f = 4
g = 1     g = 3     g = 3     g = 5
h = 1     h = 1     h = 1     h = 6
  A         B         C         M
  o <------ o <------ o <------ o
             \                 /
              \               /
               \             /
                \           /
                 o <------ o
                 D         E
               f = 2     f = 2
               g = 5     g = 5
               h = 1     h = 6
```


!SLIDE
```
                      C
                      o




                           o
                           E
```


!SLIDE
```
                      C
                      o




                 o <------ o
                 D         E
```


!SLIDE
```
            B         C
            o <------ o




                 o <------ o
                 D         E
```


!SLIDE
```
            B         C
            o <------ o
             \
              \
               \
                \
                 o <------ o
                 D         E
```


!SLIDE
```
          f = 2     f = 4
          g = 3     g = 3
          h = 1     h = 1
            B         C
            o <------ o




            diff(B,C) = { f: [2 -> 4] }




```


!SLIDE
```
          f = 2
          g = 3
          h = 1
            B
            o         diff(B,E) = {
             \            g: [3 -> 5],
              \           h: [1 -> 6],
               \      }
                \
                 o <------ o
                 D         E
                         f = 2
                         g = 5
                         h = 6
```


!SLIDE
```
          tree(M) = tree(B)

                  + diff(B,C)

                  + diff(B,E)
```


!SLIDE
```
          tree(M) = { f: 2, g: 3, h: 1 }

                  + { f: [2 -> 4] }

                  + { g: [3 -> 5]
                      h: [1 -> 6] }

                  = { f: 4, g: 5, h: 6 }
```


!SLIDE
```
f = 1     f = 2     f = 4     f = 4
g = 1     g = 3     g = 3     g = 5
h = 1     h = 1     h = 1     h = 6
  A         B         C         M
  o <------ o <------ o <------ o
             \                 /
              \               /
               \             /
                \           /
                 o <------ o
                 D         E
               f = 2     f = 2
               g = 5     g = 5
               h = 1     h = 6
```
