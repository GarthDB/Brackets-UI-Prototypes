refresh = (findex = -1) ->
	if findex > -1
		index = findex
		$('.inline-editor header li').removeClass('selected')
		$($('.inline-editor header li')[index]).addClass('selected')
	else
		index = currentIndex()
	codeBlocks = $('.inline-editor .infinte_editor .codeblock')
	selectedCodeBlock = codeBlocks[index]
	$(selectedCodeBlock).removeClass('left right')
	$('.inline-editor .infinte_editor').height($(selectedCodeBlock).height())
	if (index > 0)
		leftCodeBlocks = codeBlocks.slice(0, index)
		leftCodeBlocks.removeClass('right')
		leftCodeBlocks.addClass('left')
	if (index + 1 < codeBlocks.length)
		rightCodeBlocks = codeBlocks.slice(index + 1)
		rightCodeBlocks.removeClass('left')
		rightCodeBlocks.addClass('right')
currentIndex = () ->
	return parseInt($('.inline-editor header a').index($('.inline-editor header .selected a')))

$ ->
	refresh()
	$(document).bind 'keydown', 'j', ->
		index = currentIndex()
		if index-1 >= 0
			refresh( index-1 )
	$(document).bind 'keydown', 'k', ->
		console.log currentIndex()+2
		console.log $('.inline-editor .infinte_editor .codeblock').length
		if currentIndex()+2 <= $('.inline-editor .infinte_editor .codeblock').length
			refresh( currentIndex()+1 )
	$('.inline-editor header a').click (e)->
		index = $('.inline-editor header a').index(e.target)
		refresh(index)
