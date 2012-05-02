


$ ->
	openHeight = 0
	ruleVerticalShift = 0
	ruleElements = $('.inline.editor .rule')
	ruleContainerElement = $('.rulesContainer')[0]
	editorElement = $('.inline.editor')[0]

	selectionStart = 0
	selectionSize = Math.min(3, ruleElements.length)

	inlineClosed = true
	ruleClosed = true

	selectionIndicatorHeight = 0
	selectionIndicatorShift = 0
	selectionElement = $('.selection')[0]
	ruleNavListElements = $('.related li')
	navTopPadding = 12
	listElementPadding = 0
	modifySelectionSize = (amount)->
		if selectionSize + amount <= ruleElements.length && selectionSize + amount > 0
			selectionSize += amount
			applySelection()
	nudgeSelection = (amount)->
		if selectionStart + amount < ruleElements.length && selectionStart + amount >= 0
			selectionStart += amount
			applySelection()
	applySelection = ->
		displayedRules = ruleElements.slice(selectionStart, selectionStart + selectionSize)
		topHiddenRules = ruleElements.slice(0, selectionStart)
		newVerticalShift = 0
		for rule in topHiddenRules
			newVerticalShift += $(rule).outerHeight()
		if newVerticalShift != ruleVerticalShift
			ruleVerticalShift = newVerticalShift
			$(ruleContainerElement).css('top', -1 * ruleVerticalShift)
		newOpenHeight = 0
		for rule in displayedRules
			newOpenHeight += $(rule).outerHeight()
		if openHeight != newOpenHeight
			openHeight = newOpenHeight
			if !inlineClosed
				$(editorElement).height(openHeight)
		newSelectionIndicatorHeight = 0
		newSelectionIndicatorShift = 0
		selectedListElements = ruleNavListElements.slice(selectionStart, selectionStart + selectionSize)
		topListElements = ruleNavListElements.slice(0, selectionStart)
		for listElement in topListElements
			newSelectionIndicatorShift += $(listElement).outerHeight() + listElementPadding
			console.log $(listElement).outerHeight()
		for listElement in selectedListElements
			newSelectionIndicatorHeight += $(listElement).outerHeight() + listElementPadding
		if selectionIndicatorHeight != newSelectionIndicatorHeight
			selectionIndicatorHeight = newSelectionIndicatorHeight
		if selectionIndicatorShift != newSelectionIndicatorShift
			selectionIndicatorShift = newSelectionIndicatorShift
		$(selectionElement).height selectionIndicatorHeight
		$(selectionElement).css 'top', selectionIndicatorShift + navTopPadding
		console.log 'Start: '+selectionStart+'; SelectionSize: '+selectionSize+';'
	applySelection()
	
	$(document).keydown (event)->
		switch event.keyCode
			when 38 # up arrow
				if !inlineClosed
					nudgeSelection(-1)
				event.preventDefault()
			when 40 # down arrow
				if !inlineClosed
					nudgeSelection(1)
				event.preventDefault()
			when 67 # c key
				if !inlineClosed
					width = 0
					if ruleClosed
						$('.relatedContainer > *').each (index)->
							width += $(this).outerWidth()
					$('.relatedContainer').width(width + 1)
					ruleClosed = !ruleClosed
			when 69 # e key
				height = 0
				if inlineClosed
					height = openHeight
				$('.inline.editor').height(height)
				inlineClosed = !inlineClosed
			when 187 # = key
				modifySelectionSize(1)
			when 189 # = key
				modifySelectionSize(-1)

	



