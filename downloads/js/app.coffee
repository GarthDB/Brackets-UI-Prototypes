require.config
	paths:
		"jquery": "//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min"
	shim:
		"jquery.timeago":
			"deps": ["jquery"]
		"jquery.client":
			"deps": ["jquery"]
		"jquery.popover":
			"deps": ["jquery"]

require ['jquery', 'mustache', 'text!data.json', 'text!templates/download.html', 'text!templates/build_list.html', 'jquery.timeago', 'jquery.client'], ($, Mustache, jsonData, downloadTemplate, buildListTemplate) ->
	builds = 
		list: JSON.parse(jsonData)
	alert $.client.os
	for build in builds.list
		build.date = $.timeago(new Date(build.date))
	switch $.client.os
		when "Mac", "Win"
			download = 
				sprint: builds.list[0].sprint
				date: builds.list[0].date
				notes: builds.list[0].notes
				os: $.client.os
				url: builds.list[0].links[$.client.os]
			downloadsHTML = Mustache.render(downloadTemplate, download)
			$('#content header').append(downloadsHTML)
			buildsListHTML = Mustache.render(buildListTemplate, builds)
			$('#downloads-list').html(buildsListHTML)
			$('html').click ->
				$('#downloads-list').removeClass('show')
			$('#content a.other').click (event)->
				$('#downloads-list').toggleClass('show')
				event.stopPropagation()
				return false
			$('#downloads-list').click (event)->
				event.stopPropagation()
				return false
		else
			console.log 'other'