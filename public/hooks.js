$.subscribe('presentation:slide:didChange', function() {
  var slide   = $('div.slide:visible'),
      classes = slide.get(0).className.split(/\s+/);

  document.body.className = classes.join(' ');
});
