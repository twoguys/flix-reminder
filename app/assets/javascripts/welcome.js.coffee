$ ->
	$('#signup ul.days li').click ->
		$(this).addClass('selected').siblings().removeClass('selected')