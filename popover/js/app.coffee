$ ->
	$('#switch').click ->
		$('#popover-container').toggleClass('popoverAbove')
		$('#popover-container').toggleClass('popoverBelow')
		return false