!SLIDE title
# Commutativity


!SLIDE
```
              A + B == B + A
```


!SLIDE
```
              A - B != B - A
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
{ f: 2, g: 3, h: 1 }





```


!SLIDE
```
{ f: 2, g: 3, h: 1 }

    + { f: [2 -> 4] }   =   { f: 4, g: 3, h: 1 }



```


!SLIDE
```
{ f: 2, g: 3, h: 1 }

    + { f: [2 -> 4] }   =   { f: 4, g: 3, h: 1 }

    + { g: [3 -> 5]
        h: [1 -> 6] }   =   { f: 4, g: 5, h: 6 }
```


!SLIDE
```
{ f: 2, g: 3, h: 1 }





```


!SLIDE
```
{ f: 2, g: 3, h: 1 }

    + { g: [3 -> 5]
        h: [1 -> 6] }   =   { f: 2, g: 5, h: 6 }


```


!SLIDE
```
{ f: 2, g: 3, h: 1 }

    + { g: [3 -> 5]
        h: [1 -> 6] }   =   { f: 2, g: 5, h: 6 }

    + { f: [2 -> 4] }   =   { f: 4, g: 5, h: 6 }
```


!SLIDE title
# Serializability


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
g = 1     g = 3
h = 1
  o ------- o ------- o
  A        B \        C
              \
               \
                \ D        E
                 o ------- o

               g = 5
                         h = 6
```


!SLIDE
```
  o ------- o         o         o ------- o
  A         B         C         D         E
f = 1     f = 2     f = 4
g = 1     g = 3               g = 5
h = 1                                   h = 6
```


!SLIDE
```
  o ------- o         o ------- o         o
  A         B         D         E         C
f = 1     f = 2                         f = 4
g = 1     g = 3     g = 5
h = 1                         h = 6
```


!SLIDE title
# Non-commutative changes


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
  { f: 3, g: 2 }




```


!SLIDE
```
  { f: 3, g: 2 }

      + { g: [2 -> 6] }   =   { f: 3, g: 6 }


```


!SLIDE
```
  { f: 3, g: 2 }

      + { g: [2 -> 6] }   =   { f: 3, g: 6 }

      + { g: [2 -> 5] }   =   { f: 3, g: 5 }
```


!SLIDE
```
  { f: 3, g: 2 }




```


!SLIDE
```
  { f: 3, g: 2 }

      + { g: [2 -> 5] }   =   { f: 3, g: 5 }


```


!SLIDE
```
  { f: 3, g: 2 }

      + { g: [2 -> 5] }   =   { f: 3, g: 5 }

      + { g: [2 -> 6] }   =   { f: 3, g: 6 }
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
f = 1     f = 3
g = 2               g = 6
  o ------- o ------- o
  A        B \        C
              \
               \
                \ D        E
                 o ------- o

               g = 4     g = 5
```


!SLIDE
```
  o ------- o         o         o ------- o
  A         B         C         D         E
f = 1     f = 3
g = 2               g = 6     g = 4     g = 5
```


!SLIDE
```
  o ------- o         o ------- o         o
  A         B         D         E         C
f = 1     f = 3
g = 2               g = 4     g = 5     g = 6
```


!SLIDE
```
            | delete  | edit    | add   
  ----------+---------+---------+---------+
    add     | -       | -       | X       |
  ----------+---------+---------+---------+
    edit    | X       | X       |
  ----------+---------+---------+
    delete  | OK      |
            +---------+
```
