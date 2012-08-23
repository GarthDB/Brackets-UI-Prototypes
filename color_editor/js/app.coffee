currentColor = '#00FF00'

$ ->
	$('.current-color').html currentColor
	$('#colorpickerHolder').ColorPicker({flat: true})
	# Stuff here