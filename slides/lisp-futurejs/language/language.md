!SLIDE title
# The language

!SLIDE bullets
# Subset of Scheme
* Invented in 1975 by Steele and Sussman
* Arithmetic
* Conditional logic
* Variables
* User-defined functions
* Recursion
* Lexical closures

!SLIDE huge
```scheme
#t
```

!SLIDE huge
```scheme
#f
```

!SLIDE huge
```scheme
0
```

!SLIDE huge
```scheme
13
```

!SLIDE big
```scheme
16777216
```

!SLIDE huge
```scheme
x
```

!SLIDE big
```scheme
for-each
```

!SLIDE big
```scheme
shout!
```

!SLIDE big
```scheme
wat?
```

!SLIDE huge
```scheme
+
```

!SLIDE huge
```scheme
-
```

!SLIDE huge
```scheme
*
```

!SLIDE huge
```scheme
/
```

!SLIDE huge
```scheme
=
```

!SLIDE big
```scheme
(+ 3 4)
; => 7
```

!SLIDE
```scheme
(= (/ 8 2) 4)
; => #t
```

!SLIDE
```scheme
(= (/ 8 2) 3)
; => #f
```

!SLIDE
```scheme
(define sq
  (lambda (x)
    (define z (* x x))
    z))

(sq 5) ; => 25
```

!SLIDE
```scheme
(define fact
  (lambda (x)
    (if (= x 0)
        1
        (* (fact (- x 1))
           x))))

(fact 6) ; => 720
```

!SLIDE
```scheme
(define add
  (lambda (x)
    (lambda (y)
      (+ x y))))

((add 5) 6) ; => 11
```
