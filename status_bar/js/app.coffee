$ ->
	$('#tab-space-toggle label').click ->
		$('#tab-space-toggle label').toggleClass('selected')
	
	$('#tab-width label').click ->
		$('#tab-width > *').toggleClass('hidden')
		$('#tab-width input').focus()


	$('#tab-width input').blur ->
		$('#tab-width > *').toggleClass('hidden')
		$('#tab-width label').html($('#tab-width input').val())
		
	$('#tab-width input').keyup ->
		if (event.keyCode == 13)
			$('#tab-width input').blur()

	$('#tab-width input').focus ->
		console.log $(@).select()