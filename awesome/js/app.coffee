$ ->
	$('body > header nav a').click (e) ->
		$('body > header nav li').removeClass('selected')
		$($(e.target).parent()).addClass('selected')