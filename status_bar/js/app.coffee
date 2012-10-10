$ ->
	$('#tab-space-toggle label').click ->
		$('#tab-space-toggle label').toggleClass('selected')
	# $('#tab-width .decrement').click ->
	# 	currentValue = Number($('#tab-width label').html())
	# 	newValue = (if ((currentValue - 1) <= 1) then 1 else currentValue - 1)
	# 	$('#tab-width label').html(newValue)
	# $('#tab-width .increment').click ->
	# 	currentValue = Number($('#tab-width label').html())
	# 	newValue = currentValue + 1
	# 	$('#tab-width label').html(newValue)
	$('#tab-width label').click ->
		$('#tab-width > *').toggleClass('hidden')
		$('#tab-width input').focus()

	$('#tab-width input').blur ->
		$('#tab-width > *').toggleClass('hidden')
		$('#tab-width label').html($('#tab-width input').val())
		
	$('#tab-width input').keyup ->
		if (event.keyCode == 13)
			$('#tab-width input').blur()
