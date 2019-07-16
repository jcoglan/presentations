!SLIDE title
# A single commit


!SLIDE
```
f = 1
g = 1
  o
  A






```


!SLIDE
```
f = 1     f = 2
g = 1     g = 1
  o ------- o
  A         B






```


!SLIDE
```
f = 1     f = 2
g = 1     g = 1
  o ------- o
 A \        B
    \
     \
      \          C
       `-------- o
               f = 1
               g = 3
```


!SLIDE
```
f = 1     f = 2
g = 1     g = 1
  o ------- o ------- ?
 A \        B        /
    \               /
     \             /
      \         C /
       `-------- o
               f = 1
               g = 3
```


!SLIDE
```
f = 1     f = 2     f = 2
g = 1     g = 1     g = 3
  o ------- o ------- o
 A \        B        / M
    \               /
     \             /
      \         C /
       `-------- o
               f = 1
               g = 3
```


!SLIDE
```
f = 1     f = 2
g = 1     g = 1
  o ------- o
 A \        B
    \
     \
      \          C
       `-------- o
               f = 1
               g = 3
```


!SLIDE
```
f = 1
g = 1
  o
 A \
    \       diff(A,C) = { g: [1 -> 3] }
     \
      \          C
       `-------- o
               f = 1
               g = 3
```


!SLIDE
```
f = 1     f = 2
g = 1     g = 1
  o ------- o
  A         B

            diff(A,C) = { g: [1 -> 3] }




```


!SLIDE
```
f = 1     f = 2     f = 2
g = 1     g = 1     g = 3
  o ------- o ------- o
  A         B         M

            diff(A,C) = { g: [1 -> 3] }




```


!SLIDE
```
f = 1     f = 2     f = 2
g = 1     g = 1     g = 3
  o ------- o ------- o
 A \        B        / M
    \               /
     \             /
      \         C /
       `-------- o
               f = 1
               g = 3
```
