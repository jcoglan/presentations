!SLIDE callout
# Patterns
## Spot the generic bits, make them mixins


!SLIDE
# JavaScript mixins

```javascript
// You've seen this in Prototype, jQuery

Faye.extend = function(destination, source) {
  for (var key in source) {
    if (destination[key] !== source[key])
      destination[key] = source[key];
  }
};
```

!SLIDE bullets
# Observable

* "Every time _X_ happens, do _Y_"
* Don't hard-code side effects
* One object, many listeners
* Repeating events, always want notifying


!SLIDE
# Observable

```javascript
Faye.Observable.
    addListener = function(eventType, callback, scope) {
      var listeners = this._listeners =
                      this._listeners ||
                      {};

      listeners[eventType] = listeners[eventType] ||
                             [];

      var listener = {
        callback: callback,
        scope:    scope
      };

      listeners[eventType].push(listener);
    };
```

!SLIDE
# Observable

```javascript
Faye.Observable.
    publishEvent = function(eventType, data) {
      if (!this._listeners) return;
      if (!this._listeners[eventType]) return;

      var listeners = this._listeners[eventType];

      for (var i = 0, n = listeners.length; i < n; i++) {
        var listener = listeners[i];
        listener.callback.call(listener.scope, data);
      }
    };
```

!SLIDE bullets
# Deferrable

* "When _X_ is ready, do _Y_"
* Progress requires async computation
* One object/value, many pending blocks
* Only want notifying once
* Object may already be ready


!SLIDE
# Deferrable

```javascript
Faye.Deferrable.
    addCallback = function(callback, scope) {
      if (this._status === 'success')
        return callback.call(scope, this._deferredValue);

      var listener = {
        callback: callback,
        scope:    scope
      };

      this._callbacks = this._callbacks || [];
      this._callbacks.push(listener);
    };
```

!SLIDE
# Deferrable

```javascript
Faye.Deferrable.
    succeed = function(value) {
      this._status = 'success';
      this._deferredValue = value;
      var listeners = this._callbacks;

      for (var i = 0, n = listeners.length; i < n; i++) {
        var listener = listeners[i];
        listener.callback.call(listener.scope, data);
      }
      this._callbacks = [];
    };
```

!SLIDE
# Deferrable

```javascript
Faye.Deferrable.
    defer = function() {
      this._status = 'deferred';
      delete this._deferredValue;
    };
```
