$ ->
	$('#tab-space-toggle label').click ->
		$('#tab-space-toggle label').toggleClass('selected')
	$('#tab-width .decrement').click ->
		currentValue = Number($('#tab-width label').html())
		newValue = (if ((currentValue - 1) <= 1) then 1 else currentValue - 1)
		$('#tab-width label').html(newValue)
	$('#tab-width .increment').click ->
		currentValue = Number($('#tab-width label').html())
		newValue = currentValue + 1
		$('#tab-width label').html(newValue)