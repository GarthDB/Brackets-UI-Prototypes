$ ->
	image = new Image()
	image.src = 'img/cordova_icon.png'
	$('body > header nav a').click (e) ->
		$('body > header nav li').removeClass('selected')
		$($(e.target).parent()).addClass('selected')