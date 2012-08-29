initColor = 'rgba(80, 10, 100, 0.5)'

require ['color-editor'], (ColorEditor) ->

	callback = (colorLabel) ->
		$('.colorLabel').html colorLabel

	colorEditor = new ColorEditor $('.coloreditor')[0], initColor, callback
	
	$ ->
		$('#clickButton').click ->
			colorEditor.parseColor($('#colorInput').val())