!SLIDE title
# A chain of commits


!SLIDE
```
f = 1
g = 1
h = 1
  o
  A







```


!SLIDE
```
f = 1     f = 2
g = 1     g = 3
h = 1     h = 1
  o ------- o
  A         B







```


!SLIDE
```
f = 1     f = 2     f = 4
g = 1     g = 3     g = 3
h = 1     h = 1     h = 1
  o ------- o ------- o
  A         B         C







```


!SLIDE
```
f = 1     f = 2     f = 4
g = 1     g = 3     g = 3
h = 1     h = 1     h = 1
  o ------- o ------- o
  A        B \        C
              \
               \
                \ D
                 o
               f = 2
               g = 5
               h = 1
```


!SLIDE
```
f = 1     f = 2     f = 4
g = 1     g = 3     g = 3
h = 1     h = 1     h = 1
  o ------- o ------- o
  A        B \        C
              \
               \
                \ D        E
                 o ------- o
               f = 2     f = 2
               g = 5     g = 5
               h = 1     h = 6
```


!SLIDE
```
f = 1     f = 2     f = 4
g = 1     g = 3     g = 3
h = 1     h = 1     h = 1
  o ------- o ------- o ------- ?
  A        B \        C        /
              \               /
               \             /
                \ D       E /
                 o ------- o
               f = 2     f = 2
               g = 5     g = 5
               h = 1     h = 6
```


!SLIDE
```
f = 1     f = 2     f = 4     f = 4
g = 1     g = 3     g = 3     g = 5
h = 1     h = 1     h = 1     h = 6
  o ------- o ------- o ------- o
  A        B \        C        / M
              \               /
               \             /
                \ D       E /
                 o ------- o
               f = 2     f = 2
               g = 5     g = 5
               h = 1     h = 6
```


!SLIDE
```
                      o
                      C


                           E
                           o
```


!SLIDE
```
                      o
                      C


                 D         E
                 o ------- o
```


!SLIDE
```
            o ------- o
            B         C


                 D         E
                 o ------- o
```


!SLIDE
```
            o ------- o
           B \        C
              \
               \
                \ D        E
                 o ------- o
```


!SLIDE
```
          f = 2     f = 4
          g = 3     g = 3
          h = 1     h = 1
            o ------- o
            B         C


            diff(B,C) = { f: [2 -> 4] }




```


!SLIDE
```
          f = 2
          g = 3
          h = 1       diff(B,E) = {
            o             g: [3 -> 5]
           B \            h: [1 -> 6]
              \       }
               \
                \ D        E
                 o ------- o
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
  o ------- o ------- o ------- o
  A        B \        C        / M
              \               /
               \             /
                \ D       E /
                 o ------- o
               f = 2     f = 2
               g = 5     g = 5
               h = 1     h = 6
```
