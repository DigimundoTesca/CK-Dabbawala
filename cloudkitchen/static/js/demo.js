$(document).ready(function() {
	$('#show-overlay').on('click', function() {
		type = $(this).attr('data-type');

		$('.overlay-container').fadeIn(function() {

			window.setTimeout(function(){
				$('.window-container.' + type).addClass('window-container-visible');
			}, 100);

		});
	});

	$('.closeres').click(function() {
		$('.overlay-container').fadeOut().end().find('.window-container').removeClass('window-container-visible');
	});

});
