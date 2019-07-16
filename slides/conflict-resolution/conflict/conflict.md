!SLIDE title
# Merge conflicts


!SLIDE
```
f = 1     f = 3
g = 2     g = 2
  o ------- o
  A         B






```


!SLIDE
```
f = 1     f = 3     f = 3
g = 2     g = 2     g = 6
  o ------- o ------- o
  A         B         C






```


!SLIDE
```
f = 1     f = 3     f = 3
g = 2     g = 2     g = 6
  o ------- o ------- o
  A        B \        C
              \
               \
                \ D
                 o
               f = 3
               g = 4
```


!SLIDE
```
f = 1     f = 3     f = 3
g = 2     g = 2     g = 6
  o ------- o ------- o
  A        B \        C
              \
               \
                \ D        E
                 o ------- o
               f = 3     f = 3
               g = 4     g = 5
```


!SLIDE
```
f = 1     f = 3     f = 3
g = 2     g = 2     g = 6
  o ------- o ------- o ------- ?
  A        B \        C        /
              \               /
               \             /
                \ D       E /
                 o ------- o
               f = 3     f = 3
               g = 4     g = 5
```


!SLIDE
```
          f = 3     f = 3
          g = 2     g = 6
            o ------- o
            B         C


            diff(B,C) = { g: [2 -> 6] }



```


!SLIDE
```
          f = 3
          g = 2
            o         diff(B,E) = {
           B \            g: [2 -> 5]
              \       }
               \
                \ D        E
                 o ------- o
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
