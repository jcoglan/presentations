$.subscribe('presentation:slide:didChange', function() {
  var slide   = $('div.slide:visible'),
      classes = slide.get(0).className.split(/\s+/);

  console.log(classes);

  document.body.className = classes.join(' ');
});
