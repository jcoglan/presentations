!SLIDE title
# The interpreter

!SLIDE diagram
```
list      <- "(" items:cell* ")" <List>

cell      <- space* datum space* <Cell>

datum     <- list / bool / int / symbol

bool      <- ("#t" / "#f") <Boolean>

int       <- ("0" / [1-9] [0-9]*) <Integer>

symbol    <- (!delimiter .)+ <Symbol>

delimiter <- "(" / ")" / [\s\n\r\t]
```

!SLIDE diagram
```
                    (* 10 x)
 








```

!SLIDE diagram
```
                    (* 10 x)

       "(" --------------------------- ")"
                     <List>






```

!SLIDE diagram
```
                    (* 10 x)

<List> "(" -------------+------------- ")"
                        |
            +-----------+-----------+
            |           |           |
           "* "        "10 "       "x"
          <Cell>      <Cell>     <Cell>


```

!SLIDE diagram
```
                    (* 10 x)

<List> "(" -------------+------------- ")"
                        |
            +-----------+-----------+
            |           |           |
    <Cell> "* "        "10 "       "x"
            |           |           |
           "*"         "10"        "x"
         <Symbol>    <Integer>   <Symbol>
```

!SLIDE diagram
```
           "*"         "10"        "x"
         <Symbol>    <Integer>   <Symbol>







```

!SLIDE diagram
```
           "*"         "10"        "x"
         <Symbol>    <Integer>   <Symbol>

            |
            V
      <Procedure:*>



```

!SLIDE diagram
```
           "*"         "10"        "x"
         <Symbol>    <Integer>   <Symbol>

            |           |
            V           V
      <Procedure:*>     10



```

!SLIDE diagram
```
           "*"         "10"        "x"
         <Symbol>    <Integer>   <Symbol>

            |           |           |
            V           V           V
      <Procedure:*>     10          5



```

!SLIDE diagram
```
           "*"         "10"        "x"
         <Symbol>    <Integer>   <Symbol>

            |           |           |
            V           V           V
      <Procedure:*>     10          5


                 *(10, 5) => 50
```

!SLIDE diagram
```
             (define x (+ 2 3))
```

!SLIDE diagram
```
             (define x (+ 2 3))

"(" -----------------+------------------ ")"
                     |
       +-------------+-------------+
       |             |             |
    "define"        "x"        "(+ 2 3)"
    <Symbol>      <Symbol>       <List>
```

!SLIDE diagram
```
    "define"        "x"        "(+ 2 3)"
    <Symbol>      <Symbol>       <List>








```

!SLIDE diagram
```
    "define"        "x"        "(+ 2 3)"
    <Symbol>      <Symbol>       <List>

       |
       V
<Syntax:define>




```

!SLIDE diagram
```
    "define"        "x"        "(+ 2 3)"
    <Symbol>      <Symbol>       <List>

       |             |
       V             V
<Syntax:define>      x




```

!SLIDE diagram
```
    "define"        "x"        "(+ 2 3)"
    <Symbol>      <Symbol>       <List>

       |             |             |
       V             V             V
<Syntax:define>      x             5




```

!SLIDE diagram
```
    "define"        "x"        "(+ 2 3)"
    <Symbol>      <Symbol>       <List>

       |             |             |
       V             V             V
<Syntax:define>      x             5


           define(<Symbol:x>, 5)
           => scope.x = 5
```

