$ ->
		
	$('#toggle').click ->
		$toggle = $(this)
		$handle = $toggle.find('#handle')

		if $toggle.hasClass('off')
			$handle.animate({left: '0'}, 200)
			$toggle.removeClass('off')
			$.post('/update', {'user[state]': 'active'})
			$('#cover').hide();
		else
			$handle.animate({left: '40px'}, 200)
			$toggle.addClass('off')
			$.post('/update', {'user[state]': 'disabled'})
			$('#cover').show();
	
	$('#days li').click ->
		$day = $(this)
		$day.addClass('selected').siblings().removeClass('selected')
		$.post('/update', {'user[day_of_the_week]': $day.attr('day')})