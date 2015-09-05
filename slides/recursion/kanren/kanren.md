!SLIDE title
# Time travel


!SLIDE title
# Values
## Variables and pairs


!SLIDE

```js
class Variable {
  constructor(name) {
    this._name = name
  }

  inspect() {
    return this._name
  }

  static named(...names) {
    return names.map(name => new Variable(name))
  }
}
```


!SLIDE

```js
import { inspect } from 'util'

class Pair {
  constructor(left, right) {
    this.left  = left
    this.right = right
  }

  inspect() {
    return '(' + inspect(this.left) +
           ' . ' + inspect(this.right) + ')'
  }
}
```


!SLIDE title
# States
## Maps of variables to values


!SLIDE

```js
class State {
  constructor(vars = [], values = new Map()) {
    this._vars   = vars
    this._values = values
  }

  inspect() {
    let pairs = Array.from(this._values)
                .map(pair => pair.map(inspect).join('='))

    return '{State ' + inspect(this._vars) +
                 ' ' + pairs.join(', ') + '}'
  }
}
```


!SLIDE

```js
  createVars(...names) {
    let newVars = Variable.named(...names)
    return [
      new State(this._vars.concat(newVars), this._values),
      newVars
    ]
  }

  assign(variable, value) {
    let newValues = new Map(Array.from(this._values))
    newValues.set(variable, value)
    return new State(this._vars, newValues)
  }
```


!SLIDE

```js
let [s, [a]] = new State().createVars('a')

s.assign(a, 42)
// -> {State [ a ] a = 42}
```


!SLIDE

```js
  walk(term) {
    if (this._values.has(term))
      return this.walk(this._values.get(term))

    else if (term instanceof Pair)
      return new Pair(this.walk(term.left),
                      this.walk(term.right))

    else
      return term
  }
```


!SLIDE

```js
  unify(x, y) {
    [x, y] = [this.walk(x), this.walk(y)]

    if (x === y) return this

    if (x instanceof Variable)
      return this.assign(x, y)
    if (y instanceof Variable)
      return this.assign(y, x)

    if (x instanceof Pair && y instanceof Pair) {
      let state = this.unify(x.left, y.left)
      return state && state.unify(x.right, y.right)
    }
    return null
  }
```


!SLIDE

```js

let [s, [a, b]] = new State().createVars('a', 'b')


s.unify(a, 3).unify(b, a)
// -> {State [ a, b ], a = 3, b = 3}


s.unify(new Pair(3, a),
        new Pair(b, new Pair(5, b)))

// -> {State [ a, b ] b = 3, a = (5 . 3)}
```


!SLIDE title
# Four ‘goals’:
## `equal`, `bind`, `either`, and `both`


!SLIDE

```js
function equal(a, b) {
  return state => {
    state = state.unify(a, b)
    return state ? [state] : []
  }
}

// e.g.

let [s, [a]] = new State().createVars('a'),
    goal     = equal(a, 1)

goal(s) // -> [ {State [ a ] a = 1} ]
```


!SLIDE

```js
function bind(names, func) {
  return state => {
    let [newState, vars] = state.createVars(...names),
        goal = func(...vars)

    return goal(newState)
  }
}

// e.g.

let goal = bind(['a', 'b'], (a, b) => equal(a, b))

goal(new State())
// -> [ {State [ a, b ] a = b} ]
```


!SLIDE

```js
function either(a, b) {
  return state => {
    return a(state).concat(b(state))
  }
}

// e.g.

let goal = bind(['x'], (x) =>
             either(equal(x, 2), equal(x, 3))
           )

goal(new State())
// -> [ {State [ x ] x = 2}, {State [ x ] x = 3} ]
```


!SLIDE

```js
function both(a, b) {
  return state => {
    return a(state).reduce(function(states, aState) {
      return states.concat(b(aState))
    }, [])
  }
}

// e.g.

let goal = bind(['x', 'y'], (x, y) =>
             both(equal(x, 8), equal(y, 9))
           )

goal(new State())
// -> [ {State [ x, y ] x = 8, y = 9} ]
```


!SLIDE

```js
let goal = bind(['x', 'y'], (x, y) =>
             both(
               either(equal(x, 'red'), equal(x, 'blue')),
               equal(y, 'yellow')
             )
           )

goal(new State())

// -> [
//      {State [ x, y ] x = 'red', y = 'yellow'},
//      {State [ x, y ] x = 'blue', y = 'yellow'}
//    ]
```


!SLIDE title
# List operations
## A list is `NULL` or a `Pair` of a value and a list


!SLIDE

```js
const NULL = {}

function fromArray(array) {
  if (array.length === 0)
    return NULL
  else
    return new Pair(array[0], fromArray(array.slice(1)))
}

function fromString(string) {
  return fromArray(string.split(''))
}
```


!SLIDE

```js
function toArray(pair) {
  if (pair === NULL)
    return []
  else
    return [pair.left].concat(toArray(pair.right))
}

function toString(pair) {
  return toArray(pair).join('')
}
```


!SLIDE

```hs
append            :: [a] -> [a] -> [a]
append [] y       =  y
append (x:xs) y   =  x : append xs y
```


!SLIDE

```js
function append(x, y, z) {
  return either(
    both(
      equal(x, NULL),
      equal(y, z)
    ),
    bind(['head', 'xs', 'zs'], (head, xs, zs) =>
      both(
        both(
          equal(x, new Pair(head, xs)),
          equal(z, new Pair(head, zs))
        ),
        append(xs, y, zs)
      )
    )
  )
}
```


!SLIDE

```js
let goal = bind(['x', 'y', 'z'], (x, y, z) =>
  both(
    both(
      equal(x, fromString('rec')),
      equal(y, fromString('urse'))
    ),
    append(x, y, z)
  )
)

goal(new State()).map(s => s.results(3).map(toString))
// -> [ [ 'rec', 'urse', 'recurse' ] ]
```


!SLIDE

```js
let goal = bind(['x', 'y', 'z'], (x, y, z) =>
  both(
    both(
      equal(x, fromString('rec')),
      equal(z, fromString('recurse'))
    ),
    append(x, y, z)
  )
)

goal(new State()).map(s => s.results(3).map(toString))
// -> [ [ 'rec', 'urse', 'recurse' ] ]
```


!SLIDE

```js
let goal = bind(['x', 'y'], (x, y) =>
  append(x, y, fromString('recurse'))
)

goal(new State()).map(s => s.results(2).map(toString))

//  ->  [ [ '', 'recurse' ],
//        [ 'r', 'ecurse' ],
//        [ 're', 'curse' ],
//        [ 'rec', 'urse' ],
//        [ 'recu', 'rse' ],
//        [ 'recur', 'se' ],
//        [ 'recurs', 'e' ],
//        [ 'recurse', '' ] ]
```
