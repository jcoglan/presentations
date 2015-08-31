!SLIDE title
# Laziness
## Using specialized tools


!SLIDE

```bash
#!/bin/bash

mkdir -p compiled

for file in $(find src -name '*.coffee'); do
  ./bin/coffee -co compiled $file
done

cat compiled/*.js > coffee-script.js
```


!SLIDE commandline

    $ time ./build.sh

    real    0m13.183s


!SLIDE

```make
sources := $(shell find src -name '*.coffee')
outputs := $(sources:src/%.coffee=compiled/%.js)

coffee-script.js: $(outputs)
	cat $^ > $@

compiled/%.js: src/%.coffee compiled
	./bin/coffee -co $(dir $@) $<

compiled:
	mkdir -p $@
```


!SLIDE commandline

    $ time make
    mkdir -p compiled
    ./bin/coffee -co compiled/ src/browser.coffee
    ./bin/coffee -co compiled/ src/cake.coffee
    ./bin/coffee -co compiled/ src/coffee-script.coffee
    ./bin/coffee -co compiled/ src/command.coffee
    ./bin/coffee -co compiled/ src/grammar.coffee
    ./bin/coffee -co compiled/ src/helpers.coffee
    ./bin/coffee -co compiled/ src/index.coffee
    ./bin/coffee -co compiled/ src/lexer.coffee
    ./bin/coffee -co compiled/ src/nodes.coffee
    ./bin/coffee -co compiled/ src/optparse.coffee
    ./bin/coffee -co compiled/ src/register.coffee
    ./bin/coffee -co compiled/ src/repl.coffee
    ./bin/coffee -co compiled/ src/rewriter.coffee
    cat compiled/browser.js compiled/cake.js compiled/coffee-script.js
        compiled/command.js compiled/grammar.js compiled/helpers.js
        compiled/index.js compiled/lexer.js compiled/nodes.js compiled/optparse.js
        compiled/register.js compiled/repl.js compiled/rewriter.js >
        coffee-script.js

    real    0m13.866s



!SLIDE commandline

    $ touch src/lexer.coffee

    $ time make
    ./bin/coffee -co compiled/ src/lexer.coffee
    cat compiled/browser.js compiled/cake.js compiled/coffee-script.js
        compiled/command.js compiled/grammar.js compiled/helpers.js
        compiled/index.js compiled/lexer.js compiled/nodes.js compiled/optparse.js
        compiled/register.js compiled/repl.js compiled/rewriter.js >
        coffee-script.js

    real    0m1.360s


!SLIDE commandline

    $ touch src/grammar.coffee src/helpers.coffee src/lexer.coffee

    $ time make
    ./bin/coffee -co compiled/ src/grammar.coffee
    ./bin/coffee -co compiled/ src/helpers.coffee
    ./bin/coffee -co compiled/ src/lexer.coffee
    cat compiled/browser.js compiled/cake.js compiled/coffee-script.js
        compiled/command.js compiled/grammar.js compiled/helpers.js
        compiled/index.js compiled/lexer.js compiled/nodes.js compiled/optparse.js
        compiled/register.js compiled/repl.js compiled/rewriter.js >
        coffee-script.js

    real    0m3.385s


!SLIDE commandline

    $ touch src/grammar.coffee src/helpers.coffee src/lexer.coffee

    $ time make -j 3
    ./bin/coffee -co compiled/ src/grammar.coffee
    ./bin/coffee -co compiled/ src/helpers.coffee
    ./bin/coffee -co compiled/ src/lexer.coffee
    cat compiled/browser.js compiled/cake.js compiled/coffee-script.js
        compiled/command.js compiled/grammar.js compiled/helpers.js
        compiled/index.js compiled/lexer.js compiled/nodes.js compiled/optparse.js
        compiled/register.js compiled/repl.js compiled/rewriter.js >
        coffee-script.js

    real    0m2.377s


!SLIDE

    grammar.coffee    helpers.coffee    lexer.coffee
           |                |                 |
           |                |                 |
           V                V                 V
      grammar.js        helpers.js        lexer.js
           |                |                 |
           |                |                 |
           +----------------+-----------------+
                            |
                            V
                     coffee-script.js



!SLIDE title
# Laziness
## In general computation


!SLIDE

```hs
map               :: (a -> b) -> [a] -> [b]
map _ []          =  []
map f (x:xs)      =  f x : map f xs

filter            :: (a -> Bool) -> [a] -> [a]
filter _ []       =  []
filter p (x:xs)
    | p x         =  x : filter p xs
    | otherwise   =  filter p xs

(!!)              :: [a] -> Int -> a
(x:xs) !! 0       =  x
(x:xs) !! n       =  xs !! (n - 1)
```


!SLIDE

```hs
    (map (^ 2) (filter even [1..])) !! 2

    

    

    

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [1..])) !! 2

==  (map (^ 2) (filter even (1 : [2..]))) !! 2

    

    

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [1..])) !! 2

==  (map (^ 2) (filter even (1 : [2..]))) !! 2

==  (map (^ 2) (filter even [2..])) !! 2

    

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [1..])) !! 2

==  (map (^ 2) (filter even (1 : [2..]))) !! 2

==  (map (^ 2) (filter even [2..])) !! 2

==  (map (^ 2) (2 : filter even [3..])) !! 2

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [1..])) !! 2

==  (map (^ 2) (filter even (1 : [2..]))) !! 2

==  (map (^ 2) (filter even [2..])) !! 2

==  (map (^ 2) (2 : filter even [3..])) !! 2

==  (2 ^ 2 : map (^ 2) (filter even [3..])) !! 2

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [1..])) !! 2

==  (map (^ 2) (filter even (1 : [2..]))) !! 2

==  (map (^ 2) (filter even [2..])) !! 2

==  (map (^ 2) (2 : filter even [3..])) !! 2

==  (2 ^ 2 : map (^ 2) (filter even [3..])) !! 2

==  (map (^ 2) (filter even [3..])) !! 1
```


!SLIDE

```hs
    (map (^ 2) (filter even [3..])) !! 1

    

    

    

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [3..])) !! 1

==  (map (^ 2) (filter even (3 : [4..]))) !! 1

    

    

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [3..])) !! 1

==  (map (^ 2) (filter even (3 : [4..]))) !! 1

==  (map (^ 2) (filter even [4..])) !! 1

    

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [3..])) !! 1

==  (map (^ 2) (filter even (3 : [4..]))) !! 1

==  (map (^ 2) (filter even [4..])) !! 1

==  (map (^ 2) (4 : filter even [5..])) !! 1

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [3..])) !! 1

==  (map (^ 2) (filter even (3 : [4..]))) !! 1

==  (map (^ 2) (filter even [4..])) !! 1

==  (map (^ 2) (4 : filter even [5..])) !! 1

==  (4 ^ 2 : map (^ 2) (filter even [5..])) !! 1

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [3..])) !! 1

==  (map (^ 2) (filter even (3 : [4..]))) !! 1

==  (map (^ 2) (filter even [4..])) !! 1

==  (map (^ 2) (4 : filter even [5..])) !! 1

==  (4 ^ 2 : map (^ 2) (filter even [5..])) !! 1

==  (map (^ 2) (filter even [5..])) !! 0
```


!SLIDE

```hs
    (map (^ 2) (filter even [5..])) !! 0

    

    

    

    

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [5..])) !! 0

==  (map (^ 2) (filter even (5 : [6..]))) !! 0

    

    

    

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [5..])) !! 0

==  (map (^ 2) (filter even (5 : [6..]))) !! 0

==  (map (^ 2) (filter even [6..])) !! 0

    

    

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [5..])) !! 0

==  (map (^ 2) (filter even (5 : [6..]))) !! 0

==  (map (^ 2) (filter even [6..])) !! 0

==  (map (^ 2) (6 : filter even [7..])) !! 0

    

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [5..])) !! 0

==  (map (^ 2) (filter even (5 : [6..]))) !! 0

==  (map (^ 2) (filter even [6..])) !! 0

==  (map (^ 2) (6 : filter even [7..])) !! 0

==  (6 ^ 2 : map (^ 2) (filter even [7..])) !! 0

    

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [5..])) !! 0

==  (map (^ 2) (filter even (5 : [6..]))) !! 0

==  (map (^ 2) (filter even [6..])) !! 0

==  (map (^ 2) (6 : filter even [7..])) !! 0

==  (6 ^ 2 : map (^ 2) (filter even [7..])) !! 0

==  6 ^ 2

    
```


!SLIDE

```hs
    (map (^ 2) (filter even [5..])) !! 0

==  (map (^ 2) (filter even (5 : [6..]))) !! 0

==  (map (^ 2) (filter even [6..])) !! 0

==  (map (^ 2) (6 : filter even [7..])) !! 0

==  (6 ^ 2 : map (^ 2) (filter even [7..])) !! 0

==  6 ^ 2

==  36    
```
