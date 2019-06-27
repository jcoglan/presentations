!SLIDE title
# Merge conflicts


!SLIDE
```
f = 1     f = 3
g = 2     g = 2
  A         B
  o <------ o








```


!SLIDE
```
f = 1     f = 3     f = 3
g = 2     g = 2     g = 6
  A         B         C
  o <------ o <------ o








```


!SLIDE
```
f = 1     f = 3     f = 3
g = 2     g = 2     g = 6
  A         B         C
  o <------ o <------ o
             \
              \
               \
                \
                 o
                 D
               f = 3
               g = 4
```


!SLIDE
```
f = 1     f = 3     f = 3
g = 2     g = 2     g = 6
  A         B         C
  o <------ o <------ o
             \
              \
               \
                \
                 o <------ o
                 D         E
               f = 3     f = 3
               g = 4     g = 5
```


!SLIDE
```
f = 1     f = 3     f = 3
g = 2     g = 2     g = 6
  A         B         C
  o <------ o <------ o <------ ?
             \                 /
              \               /
               \             /
                \           /
                 o <------ o
                 D         E
               f = 3     f = 3
               g = 4     g = 5
```


!SLIDE
```
          f = 3     f = 3
          g = 2     g = 6
            B         C
            o <------ o




            diff(B,C) = { g: [2 -> 6] }



```


!SLIDE
```
          f = 3
          g = 2
            B
            o         diff(B,E) = {
             \            g: [2 -> 5],
              \       }
               \
                \
                 o <------ o
                 D         E
                         f = 3
                         g = 5
```


!SLIDE
```
          tree(M) = tree(B)

                  + diff(B,C)

                  + diff(B,E)
```


!SLIDE
```
          tree(M) = { f: 3, g: 2 }

                  + { g: [2 -> 6] }

                  + { g: [2 -> 5] }

                  = { f: 3, g: 😱😱😱 }
```
