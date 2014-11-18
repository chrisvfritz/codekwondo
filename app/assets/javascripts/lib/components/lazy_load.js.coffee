$ ->
  $('img.is_lazy').lazyload
    effect: 'fadeIn'

  # This is needed to load images already visible on the screen
  setTimeout ->
    $(window).trigger 'scroll'
  , 1000
