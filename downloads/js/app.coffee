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
	$('html').click ->
		$('#downloads-list').removeClass('show')
	$('#content a.other').click (event)->
		$('#downloads-list').toggleClass('show')
		event.stopPropagation()
		return false
	$('#downloads-list').click (event)->
		event.stopPropagation()
		return false
	builds = 
		list: JSON.parse(jsonData)
	for build in builds.list
		build.date = $.timeago(new Date(build.date))
	switch $.client.os
		when "Mac"
			download = 
				sprint: builds.list[0].sprint
				date: builds.list[0].date
				notes: builds.list[0].notes
				os: $.client.os
				url: builds.list[0].links[$.client.os].url
				filetype: builds.list[0].links[$.client.os].filetype
				filename: builds.list[0].links[$.client.os].filename
				filesize: builds.list[0].links[$.client.os].filesize
			downloadsHTML = Mustache.render(downloadTemplate, download)
			$('#content header').append(downloadsHTML)
			buildsListHTML = Mustache.render(buildListTemplate, builds)
			$('#downloads-list').html(buildsListHTML)

		when "Windows", "Win"
			os = "Windows"
			download = 
				sprint: builds.list[0].sprint
				date: builds.list[0].date
				notes: builds.list[0].notes
				os: $.client.os
				url: builds.list[0].links[os].url
				filetype: builds.list[0].links[os].filetype
				filename: builds.list[0].links[os].filename
				filesize: builds.list[0].links[os].filesize
			downloadsHTML = Mustache.render(downloadTemplate, download)
			$('#content header').append(downloadsHTML)
			buildsListHTML = Mustache.render(buildListTemplate, builds)
			$('#downloads-list').html(buildsListHTML)
			$('#content > header > img').src
			$('#content > header > img').attr('src', 'img/sprint_17_screenshot_win_@2X.png')
		else
			console.log 'other'