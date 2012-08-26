initColor = 'rgb(80, 10, 100)'

require ['color-editor'], (ColorEditor) ->
	colorEditor = new ColorEditor $('.coloreditor')[0], initColor
	
	$ ->
		$('#clickButton').click ->
			colorEditor.parseColor($('#colorInput').val())