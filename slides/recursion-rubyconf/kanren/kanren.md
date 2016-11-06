!SLIDE title
# Time travel


!SLIDE title subhead
# Values
## Variables and pairs


!SLIDE code

```ruby
class Variable
  def initialize(name)
    @name = name
  end

  def inspect
    @name.to_s
  end

  def self.named(*names)
    names.map { |name| new(name) }
  end
end
```


!SLIDE code

```ruby
class Pair
  attr_reader :left, :right

  def initialize(left, right)
    @left, @right = left, right
  end

  def inspect
    "(#{@left.inspect} . #{@right.inspect})"
  end
end
```


!SLIDE title subhead
# States
## Maps of variables to values


!SLIDE code

```ruby
class State
  def initialize(vars = [], values = {})
    @vars, @values = vars, values
  end

  def inspect
    pairs = @values.map { |pair| pair.map(&:inspect) * ' = ' }
    "{State #{@vars.inspect} #{pairs * ', '}}"
  end
```


!SLIDE code

```ruby
  def create_vars(*names)
    new_vars = Variable.named(*names)
    [State.new(@vars + new_vars, @values), new_vars]
  end

  def assign(variable, value)
    State.new(@vars, @values.merge(variable => value))
  end
```


!SLIDE code

```ruby
s, (a,) = State.new.create_vars(:a)

s.assign(a, 42)
# => {State [a] a = 42}
```


!SLIDE code

```ruby
  def walk(term)
    if @values.has_key? term
      walk(@values[term])
    elsif term.is_a? Pair
      Pair.new(walk(term.left), walk(term.right))
    else
      term
    end
  end
```


!SLIDE code

```ruby
  def unify(x, y)
    x, y = walk(x), walk(y)

    return self if x == y

    return assign(x, y) if x.is_a? Variable
    return assign(y, x) if y.is_a? Variable

    if x.is_a? Pair and y.is_a? Pair
      state = unify(x.left, y.left)
      return state && state.unify(x.right, y.right)
    end
  end
```


!SLIDE code

```ruby
s, (a, b) = State.new.create_vars(:a, :b)


s.unify(a, 3).unify(b, a)
# => {State [a, b], a = 3, b = 3}


s.unify(Pair.new(3, a),
        Pair.new(b, Pair.new(5, b)))

# => {State [a, b] b = 3, a = (5 . 3)}
```


!SLIDE title subhead
# Four ‘goals’:
## `equal`, `bind`, `either`, and `both`


!SLIDE code

```ruby
class Goal
  def initialize(&block)
    @block = block
  end

  def pursue(state)
    @block.call(state)
  end
end
```


!SLIDE code

```ruby
def Goal.equal(a, b)
  new do |state|
    [*state.unify(a, b)]
  end
end

# e.g.

s, (a,) = State.new.create_vars(:a),
goal    = Goal.equal(a, 1)

goal.pursue(s) # => [ {State [a] a = 1} ]
```


!SLIDE code

```ruby
def Goal.bind(names, &block)
  new do |state|
    new_state, vars = state.create_vars(*names)
    goal = block.call(*vars)
    goal.pursue(new_state)
  end
end

# e.g.

goal = Goal.bind([:a, :b]) { |a, b| Goal.equal(a, b) }

goal.pursue(State.new)
# => [ {State [a, b] a = b} ]
```


!SLIDE code

```ruby
def Goal.either(a, b)
  new do |state|
    a.pursue(state) + b.pursue(state)
  end
end

# e.g.

goal = Goal.bind([:x]) { |x|
  Goal.either(Goal.equal(x, 2), Goal.equal(x, 3))
}

goal.pursue(State.new)
# => [ {State [x] x = 2}, {State [x] x = 3} ]
```


!SLIDE code

```ruby
def Goal.both(a, b)
  new do |state|
    a.pursue(state).inject([]) do |states, a_state|
      states + b.pursue(a_state)
    end
  end
end

# e.g.

goal = Goal.bind([:x, :y]) { |x, y|
  Goal.both(Goal.equal(x, 8), Goal.equal(y, 9))
}

goal.pursue(State.new)
# => [ {State [x, y] x = 8, y = 9} ]
```


!SLIDE code

```ruby
goal = Goal.bind([:x, :y]) { |x, y|
  Goal.both(
    Goal.either(Goal.equal(x, :red), Goal.equal(x, :blue)),
    Goal.equal(y, :yellow)
  )
}

goal.pursue(State.new)

# => [
#      {State [x, y] x = :red, y = :yellow},
#      {State [x, y] x = :blue, y = :yellow}
#    ]
```


!SLIDE title subhead
# List operations
## A list is `NULL` or a `Pair` of a value and a list


!SLIDE code

```ruby
class List
  NULL = List.new
end

def List.from_array(array)
  if array.empty?
    List::NULL
  else
    Pair.new(array.first, from_array(array[1..-1]))
  end
end

def List.from_string(string)
  from_array(string.chars)
end
```


!SLIDE code

```ruby
def List.to_array(pair)
  if pair == List::NULL
    []
  else
    [pair.left] + to_array(pair.right)
  end
end

def List.to_string(pair)
  to_array(pair) * ''
end
```


!SLIDE code

```hs
append          :: [a] -> [a] -> [a]
append [] y     =  y
append (x:xs) y =  x : append xs y
```


!SLIDE code

```ruby
def List.append(x, y, z)
  Goal.either(
    Goal.both(
      Goal.equal(x, List::NULL),
      Goal.equal(y, z)
    ),
    Goal.bind([:head, :xs, :zs]) { |head, xs, zs|
      Goal.both(
        Goal.both(
          Goal.equal(x, Pair.new(head, xs)),
          Goal.equal(z, Pair.new(head, zs))
        ),
        append(xs, y, zs)
      )
    }
  )
end
```


!SLIDE code

```ruby
goal = Goal.bind([:x, :y, :z]) { |x, y, z|
  Goal.both(
    Goal.both(
      Goal.equal(x, List.from_string('rec')),
      Goal.equal(y, List.from_string('urse'))
    ),
    List.append(x, y, z)
  )
}

goal.pursue(State.new).map { |s|
  s.results(3).map(&List.method(:to_string))
}
# => [ [ 'rec', 'urse', 'recurse' ] ]
```


!SLIDE code

```ruby
goal = Goal.bind([:x, :y, :z]) { |x, y, z|
  Goal.both(
    Goal.both(
      Goal.equal(x, List.from_string('rec')),
      Goal.equal(z, List.from_string('recurse'))
    ),
    List.append(x, y, z)
  )
}

goal.pursue(State.new).map { |s|
  s.results(3).map(&List.method(:to_string))
}
# => [ [ 'rec', 'urse', 'recurse' ] ]
```


!SLIDE code

```ruby
goal = Goal.bind([:x, :y]) { |x, y|
  List.append(x, y, List.from_string('recurse'))
}

goal.pursue(State.new).map { |s|
  s.results(2).map(&List.method(:to_string))
}

#  =>  [ [ '', 'recurse' ],
#        [ 'r', 'ecurse' ],
#        [ 're', 'curse' ],
#        [ 'rec', 'urse' ],
#        [ 'recu', 'rse' ],
#        [ 'recur', 'se' ],
#        [ 'recurs', 'e' ],
#        [ 'recurse', '' ] ]
```
