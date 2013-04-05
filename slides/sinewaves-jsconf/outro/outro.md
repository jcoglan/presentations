!SLIDE center
![Logo](logo.png)


!SLIDE
# Drawn with JavaScript

```javascript
var iterate = function() {
  var nx = Math.sin(a*y) - Math.cos(b*x),
      ny = Math.sin(c*x) - Math.cos(d*y),

      px = Math.round(512 + 200 * nx),
      py = Math.round(512 + 200 * ny),

      pixel = ctx.getImageData(px,py,1,1).data,
      v     = Math.max(pixel[0] - k, 0);

  ctx.fillStyle = 'rgb(' + [v,v,v].join(',') + ')';
  ctx.fillRect(px,py,1,1);

  x = nx;
  y = ny;
};
```

!SLIDE bullets
# Thank you!

```javascript
var links = [
  'http://jcoglan.com',

  'http://faye.jcoglan.com',

  'http://expressjs.com',

  'https://github.com/bfirsh/dynamicaudio.js',

  'https://github.com/oampo/Audiolet'
]
```