@yPositions = []


$ ->
	@currentSection = $('#content > section')[0]
	@upatePositions = () ->
		@yPositions = []
		for element in $('#content > section')
			position = $(element).position()
			@yPositions.push position.top

	@upatePositions()

	@changeSection = (index) ->
		@currentSection = $('#content > section')[index]
		$('body > header nav li').removeClass('selected')
		$($('body > header nav li')[index]).addClass('selected')

	image = new Image()
	image.src = 'img/cordova_icon.png'
	$('body > header nav a').click (e) =>
		# $('body > header nav li').removeClass('selected')
		# $($(e.target).parent()).addClass('selected')
		index = $('body > header nav a').index(e.target)
		$('body').animate({scrollTop : @yPositions[index]},'slow');
		return false
	$(window).resize () =>
		@upatePositions()
	$(window).scroll (e) =>
		scrollPosition = $(window).scrollTop()
		height = $(window).height()
		for sectionPosition, index in @yPositions
			if (sectionPosition - height/2) >= scrollPosition
				newSection = $('#content > section')[index - 1]
				break
			else
				newSection = $('#content > section')[index]
		if newSection != @currentSection
			@changeSection(index-1)