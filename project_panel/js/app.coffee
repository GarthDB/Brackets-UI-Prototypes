$ ->
	moveSelection = (element) ->
		position = $(element).offset()
		$('#file_selection').css( 'top', position.top)
	
	moveSelection('li.file.selected')

	$('li.file a').click ->
		$('li.file.selected').removeClass('selected')
		newSelectedElement = $(this).parent()
		newSelectedElement.addClass('selected')
		moveSelection(newSelectedElement)
	$('li.folder a').click ->
		$(this).parent().toggleClass('collapsed')


