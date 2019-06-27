!SLIDE title
# A single commit


!SLIDE
```
f = 1
g = 1
  A
  o








```


!SLIDE
```
f = 1     f = 2
g = 1     g = 1
  A         B
  o <------ o








```


!SLIDE
```
f = 1     f = 2
g = 1     g = 1
  A         B
  o <------ o
   \
    \
     \
      \
       `-------- o
                 C
               f = 1
               g = 3
```


!SLIDE
```
f = 1     f = 2
g = 1     g = 1
  A         B
  o <------ o <------ ?
   \                 /
    \               /
     \             /
      \           /
       `-------- o
                 C
               f = 1
               g = 3
```


!SLIDE
```
f = 1     f = 2     f = 2
g = 1     g = 1     g = 3
  A         B         M
  o <------ o <------ o
   \                 /
    \               /
     \             /
      \           /
       `-------- o
                 C
               f = 1
               g = 3
```


!SLIDE
```
f = 1     f = 2
g = 1     g = 1
  A         B
  o <------ o
   \
    \
     \
      \
       `-------- o
                 C
               f = 1
               g = 3
```


!SLIDE
```
f = 1
g = 1
  A
  o
   \
    \       diff(A,C) = { g: [1 -> 3] }
     \
      \
       `-------- o
                 C
               f = 1
               g = 3
```


!SLIDE
```
f = 1     f = 2
g = 1     g = 1
  A         B
  o <------ o

            diff(A,C) = { g: [1 -> 3] }






```


!SLIDE
```
f = 1     f = 2     f = 2
g = 1     g = 1     g = 3
  A         B         M
  o <------ o <------ o

            diff(A,C) = { g: [1 -> 3] }






```


!SLIDE
```
f = 1     f = 2     f = 2
g = 1     g = 1     g = 3
  A         B         M
  o <------ o <------ o
   \                 /
    \               /
     \             /
      \           /
       `-------- o
                 C
               f = 1
               g = 3
```
