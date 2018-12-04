!SLIDE title
# Mergey Christmas!


!SLIDE
```
f = 1     f = 3     f = 6
g = 2     g = 2     g = 2
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
f = 1     f = 3     f = 6
g = 2     g = 2     g = 2
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
          f = 3     f = 6
          g = 2     g = 2
            B         C
            o <------ o




          diff(B,C) = { f => [3, 6] }



```


!SLIDE
```
          f = 3
          g = 2
            B
            o       diff(B,E) = { g => [2, 5] }
             \
              \
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

                  + { f => [3, 6] }

                  + { g => [2, 5] }

                  = { f: 6, g: 5 }
```


!SLIDE
```
f = 1     f = 3     f = 6     f = 6
g = 2     g = 2     g = 2     g = 5
  A         B         C         M
  o <------ o <------ o <------ o
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
f = 1     f = 3     f = 3
g = 2     g = 2     g = 7
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
          f = 3
          g = 2
            B
            o       diff(B,E) = { g => [2, 5] }
             \
              \
               \
                \
                 o <------ o
                 D         E
                         f = 3
                         g = 5
```


!SLIDE
```
          f = 3     f = 3
          g = 2     g = 7
            B         C
            o <------ o




          diff(B,C) = { g => [2, 7] }



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

                  + { g => [2, 7] }

                  + { g => [2, 5] }

                  = { f: 3, g: ??? }
```


!SLIDE
```
  { f: 3, g: 2 }

      + { f => [3, 6] }   =   { f: 6, g: 2 }

      + { g => [2, 5] }   =   { f: 6, g: 5 }



  { f: 3, g: 2 }

      + { g => [2, 5] }   =   { f: 3, g: 5 }

      + { f => [3, 6] }   =   { f: 6, g: 5 }
```


!SLIDE
```
  { f: 3, g: 2 }

      + { g => [2, 7] }   =   { f: 3, g: 7 }

      + { g => [2, 5] }   =   { f: 3, g: 😱 }



  { f: 3, g: 2 }

      + { g => [2, 5] }   =   { f: 3, g: 5 }

      + { g => [2, 7] }   =   { f: 3, g: 😱 }
```


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

      + { x => [∅, 4] }   =   { f: 3, x: 4 }

      + { x/y => [∅, 6] }

                  =   { f: 3, x: 4, x/y: 6 }
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

          diff(D,C) = { f => [5, 4] }


                 o
                 D
               f = 5
               g = 2
```


!SLIDE
```






          diff(D,E) = { g => [2, 6] }


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

                   + { f => [5, 4] }

                   + { g => [2, 6] }

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


      diff(B,A) = { f => [3, 1] }




```


!SLIDE
```
              f = 3     f = 3
              g = 2     g = 4
                B         C
                o <------ o


      diff(B,C) = { g => [2, 4] }




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

               + { f => [3, 1] }

               + { g => [2, 4] }
```


!SLIDE
```
    f = 1     f = 3     f = 3     f = 1
    g = 2     g = 2     g = 4     g = 4
      A         B         C        -B
      o <------ o <------ o <------ o


      tree(-B) = { f: 1, g: 4 }




```
