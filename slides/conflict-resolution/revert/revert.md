!SLIDE title
# Revert


!SLIDE
```
    f = 1     f = 3     f = 3
    g = 2     g = 2     g = 4
      A         B         C
      o <------ o <------ o
```


!SLIDE
```
    f = 1     f = 3     f = 3     f = 1
    g = 2     g = 2     g = 4     g = 4
      A         B         C        -B
      o <------ o <------ o <------ o
```


!SLIDE
```
    f = 1     f = 3
    g = 2     g = 2
      A         B
      o <------ o


      diff(B,A) = { f: [3 -> 1] }




```


!SLIDE
```
              f = 3     f = 3
              g = 2     g = 4
                B         C
                o <------ o


      diff(B,C) = { g: [2 -> 4] }




```


!SLIDE
```
    f = 1     f = 3     f = 3
    g = 2     g = 2     g = 4
      A         B         C        -B
      o <------ o <------ o <------ o


      tree(-B) = tree(B)

               + diff(B,A)

               + diff(B,C)
```


!SLIDE
```
    f = 1     f = 3     f = 3
    g = 2     g = 2     g = 4
      A         B         C        -B
      o <------ o <------ o <------ o


      tree(-B) = { f: 3, g: 2 }

               + { f: [3 -> 1] }

               + { g: [2 -> 4] }
```


!SLIDE
```
    f = 1     f = 3     f = 3     f = 1
    g = 2     g = 2     g = 4     g = 4
      A         B         C        -B
      o <------ o <------ o <------ o


      tree(-B) = { f: 1, g: 4 }




```
