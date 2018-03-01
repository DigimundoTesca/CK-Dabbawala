$(document).ready(function() {
  $('.show-overlay').on('click', function() {
    type = $(this).attr('data-type');
    $('.overlay-container').fadeIn();
    $('.window-container.' + type).addClass('window-container-visible');
    document.getElementById('cart-overlay').scrollIntoView();
  });

  $('.closeres').click(function() {
    $('.overlay-container').fadeOut();
    $('.window-container').removeClass('window-container-visible');
  });

});
