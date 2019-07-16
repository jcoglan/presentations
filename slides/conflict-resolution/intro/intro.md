!SLIDE title
# Conflict resolution
## James Coglan, dxw digital


!SLIDE bullets
- Better understand Git merges
- Why do conflicts happen?
- How can we relate this to other data systems?


!SLIDE title
# What is Git?


!SLIDE
```
    f = 1

      o
      A






```

!SLIDE
```
    f = 1     f = 1
              g = 2
      o ------- o
      A         B






```

!SLIDE
```
    f = 1     f = 1     f = 3
              g = 2     g = 2
      o ------- o ------- o
      A         B         C






```

!SLIDE
```
    f = 1     f = 1     f = 3
              g = 2     g = 2     g = 2
      o ------- o ------- o ------- o
      A         B         C         D






```

!SLIDE
```
    f = 1     f = 1     f = 3
              g = 2     g = 2     g = 2
      o ------- o ------- o ------- o
     A \        B         C         D
        \
         \
          \ E
           o
         f = 1
         h = 4
```

!SLIDE
```
    f = 1     f = 1     f = 3
              g = 2     g = 2     g = 2
      o ------- o ------- o ------- o
     A \        B         C         D
        \
         \
          \ E        F
           o ------- o
         f = 1     f = 5
         h = 4     h = 6
```
