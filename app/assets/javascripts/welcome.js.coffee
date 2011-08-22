$ ->
	$('section.phone').animate {opacity: 1, 'margin-top': 0}, 1000, ->
		$('section.explanation').animate({opacity: 1}, 500)
		
	$('#signup ul.days li').click ->
		$(this).addClass('selected').siblings().removeClass('selected')