$ ->
  refresh()
  $('#frame').load ()->
    htmlstring = '<ul>'
    @elements = $("#frame").contents().find('body *')
    for element in @elements
      htmlstring += "<li><a href='#'>#{$(element).prop('tagName').toLowerCase()}</a></li>"
    htmlstring += '</ul>'
    $($('body > aside')[0]).html htmlstring
    $('body > aside a').click (e)=>
      index = $(e.target).parent().index()
      @selectedElement = @elements[index]
      offset = $(@selectedElement).offset()
      overlayStyles = "outline: 4px solid rgba(94, 167, 255, 1); box-shadow: 0 0 30px #42adfc; width:#{$(@selectedElement).width() - 2}px; height:#{$(@selectedElement).height() - 2}px; position:absolute; top:#{offset.top}px; left:#{offset.left + 300}px;"
      overlay = "<div class='brackets-highlight' data-highlight-index='#{index}' style='#{overlayStyles}'></div>"
      $("#content").append overlay
      console.log overlay
      return false

refresh = (url) ->
  if(url)
    $('#frame').attr 'src', url