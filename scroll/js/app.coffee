$ ->
	waitForFinalEvent = (->
		timers = {}
		(callback, ms, uniqueId) ->
			uniqueId = "Don't call this twice without a uniqueId"  unless uniqueId
			clearTimeout timers[uniqueId]  if timers[uniqueId]
			timers[uniqueId] = setTimeout(callback, ms)
	)()
	$("#innerbox").antiscroll()
	$("#removerow").click ->
		$("tr").last().remove()
		$("#innerbox").antiscroll().refresh()

	$("#addrow").click ->
		$(".box-inner table").append "<tr><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td></tr>"
		$("#innerbox").antiscroll().refresh()

	$(window).resize ->
		waitForFinalEvent (->
			$("#innerbox").antiscroll().refresh()
		
		#...
		), 200, "some unique string"

	

	$("#innerbox").antiscroll()
	
	$('.toggle').click ->
		$('.stuff').toggleClass('too-much')