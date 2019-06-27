!SLIDE title
# Incompatible changes


!SLIDE
```
f = 1     f = 3     f = 3
                    x = 4
  A         B         C
  o <------ o <------ o <------ ?
             \                 /
              \               /
               \             /
                \           /
                 o <------ o
                 D         E
               f = 3     f = 3
             x/y = 5   x/y = 6
```


!SLIDE
```
  { f: 3 }

      + { x: [∅ -> 4] }   =   { f: 3, x: 4 }

      + { x/y: [∅ -> 6] }

                  =   { f: 3, x: 4, x/y: 6 }
```
