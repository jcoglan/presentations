!SLIDE title
# Incompatible changes


!SLIDE
```
f = 1     f = 3     f = 3
                    x = 4
  o ------- o ------- o ------- ?
  A        B \        C        /
              \               /
               \             /
                \ D       E /
                 o ------- o
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
