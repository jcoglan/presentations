!SLIDE bullets
# Mixins

* We can add any methods we like
* To any object
* At any time


!SLIDE
# Mixins

```javascript
Object.extend = function(destination, source) {
  for (var key in source) {
    destination[key] = source[key];
  }
  return destination;
};
```

!SLIDE
# Mixins

```javascript
Enumerable = {
  map: function(block, context) {
    var result = [];
    this.forEach(function(item) {
      result.push(block.call(context, item));
    });
    return result;
  },

  filter: function(block, context) {
    var result = [];
    this.forEach(function(item) {
      if (block.call(context, item))
        result.push(item);
    });
    return result;
  }
};
```

!SLIDE
# Mixins

```javascript
Collection = function(list) {
  this._list = list;
};

Collection.prototype.forEach = function(block, context) {
  var list = this._list,
      n    = list.length;

  for (var i = 0; i < n; i++)
    block.call(context, list[i], i);
};

Object.extend(Collection.prototype, Enumerable);
```

!SLIDE
# Mixins

```javascript
var list = new Collection([1,2,3,4]);

list.map(function(x) { return x * x })
// -> [1,4,9,16]
```
