!SLIDE title
# Revert


!SLIDE
```
    f = 1     f = 3     f = 3
    g = 2     g = 2     g = 4
      o ------- o ------- o
      A         B         C







```


!SLIDE
```
    f = 1     f = 3     f = 3     f = 1
    g = 2     g = 2     g = 4     g = 4
      o ------- o ------- o ------- o
      A         B         C        -B







```


!SLIDE
```
    f = 1     f = 3
    g = 2     g = 2
      o ------- o
      A         B


      diff(B,A) = { f: [3 -> 1] }




```


!SLIDE
```
              f = 3     f = 3
              g = 2     g = 4
                o ------- o
                B         C


      diff(B,C) = { g: [2 -> 4] }




```


!SLIDE
```
    f = 1     f = 3     f = 3
    g = 2     g = 2     g = 4
      o ------- o ------- o ------- o
      A         B         C        -B


      tree(-B) = tree(B)

               + diff(B,A)

               + diff(B,C)
```


!SLIDE
```
    f = 1     f = 3     f = 3
    g = 2     g = 2     g = 4
      o ------- o ------- o ------- o
      A         B         C        -B


      tree(-B) = { f: 3, g: 2 }

               + { f: [3 -> 1] }

               + { g: [2 -> 4] }
```


!SLIDE
```
    f = 1     f = 3     f = 3     f = 1
    g = 2     g = 2     g = 4     g = 4
      o ------- o ------- o ------- o
      A         B         C        -B


      tree(-B) = { f: 1, g: 4 }




```
