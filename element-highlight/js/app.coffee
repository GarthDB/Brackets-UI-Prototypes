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
      overlayStyles = '-webkit-box-shadow:0 0 4px #5EA7FC; width:#{$(@selectedElement).width()}px; height:#{$(@selectedElement).height()}px; position:absolute; top:#{offset.top}px; left:#{offset.left + 300}px;'
      overlay = "<div class='brackets-highlight' data-highlight-index='#{index}' style='#{overlayStyles}'></div>"
      console.log $("#content").append overlay
      return false

refresh = (url) ->
  if(url)
    $('#frame').attr 'src', url