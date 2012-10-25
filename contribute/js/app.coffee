require.config
	paths:
		"jquery": "//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min"
		"trello": "https://api.trello.com/1/client.js?key=1953abc13ad18fd16a66a2a1d938a07a&dummy="
	# 	"underscore": "libs/underscore"
	# 	"backbone": "libs/backbone"
	shim:
		"trello":
			"deps": ["jquery"]
		"jquery.timeago":
			"deps": ["jquery"]
	# 	"underscore":
	# 		"deps": ["zepto"]
	# 		"exports": "_"
	# 	"zepto":
	# 		"exports": "$"
	# 	"backbone":
	# 		"deps": ["underscore"]
	# 		"exports": "Backbone"
	
require ['jquery', 'mustache', 'trello', 'text!views/issue.html', 'text!views/feature.html', 'jquery.timeago'], ($, Mustache, Trello, issueTemplate, featureTemplate) ->
	$.ajax
		url: 'https://api.github.com/repos/adobe/brackets/issues?labels=starter+bug'
		dataType: 'jsonp'
		success: (data) ->
			data = data.data
			issuesHTML = ''
			for issue in data
				# date = $.timeago(new Date(issue.created_at))
				issue.date = jQuery.timeago(new Date(issue.created_at))
				issuesHTML += Mustache.render(issueTemplate, issue)
			$('#starter-issues > .content').html(issuesHTML)
			$('#starter-issues').show()
	$.ajax
		url: 'https://api.trello.com/1/boards/4f90a6d98f77505d7940ce88/cards?key=1953abc13ad18fd16a66a2a1d938a07a&filter=open&fields=badges,name,url,labels'
		dataType: 'jsonp'
		success: (data) ->
			cards = data.filter (card)->
				keep = false
				for label in card.labels
					if label.name is 'Starter Feature'
						keep = true
						break
				return keep
			featuresHTML = ''
			for card in cards
				featuresHTML += Mustache.render(featureTemplate, card)
			$('#starter-features > .content').html(featuresHTML)
			$('#starter-features').show()
	# $('body').ready ->
		# console.log Trello
	