!SLIDE center zoom
![Server layout](servers.png)


!SLIDE
# JSON representation

    @@@ javascript
    {
      "amp": 0.5, "ampMute": false,
      "share": 0, "shareMute": true,
      "wave": "square",
      "am": {"freq": 0, "amp": 0},
      "env": {"a": 0, "d": 0, "s": 1, "r": 0},
      "loop": false,
      "keys": {
        "key": "A", "root": ["D", 2],
        "begin": "Z", "end": "P"
      },
      "recording": {
        "duration": 8010,
        "events": [
          [0, "keyDown", 415.3046971027745],
          [260, "keyDown", 554.3652613167977],
          [300, "keyUp", 0],
          [460, "keyUp", 0],
          ...


!SLIDE
# Synching data

    @@@ javascript
    Performance.prototype.toJSON = function() {
      return {
        channels: this._channels.map(function(c) {
          return c.toJSON();
        });
      };
    };
    
    // Save
    $.post('/performances/1', performance);
    
    // Fetch
    $.get('/performances/1', update);
    
    // Update
    faye.subscribe('/performances/1', update);



