
$ ->
  refresh()
  $('#frame').load ()->
    @delay = (ms, func) -> setTimeout func, ms
    htmlstring = '<ul>'
    @elements = $("#frame").contents().find('body *')
    for element in @elements
      htmlstring += "<li><a href='#'>#{$(element).prop('tagName').toLowerCase()}</a></li>"
    htmlstring += '</ul>'
    $($('body > aside')[0]).html htmlstring
    $('body > aside a').click (e)=>
      index = $(e.target).parent().index()
      @selectedElement = @elements[index]
      existingElement = $('#content .brackets-highlight[data-highlight-index="'+index+'"]')
      if (existingElement.length > 0)
        $(existingElement).css('opacity', '0')
        @delay 200, ->
          existingElement.remove()
      else
        offset = $(@selectedElement).offset()
        overlayStyles = "background: rgba(94,167,255, 0.1);"
        overlayStyles += "box-shadow: 0 0 8px 2px rgba(94,167,255, 0.3), inset 0 0 4px 1px rgba(255,255,255,0.6);"
        overlayStyles += "opacity: 0; -webkit-transition: opacity 0.2s; width:#{$(@selectedElement).width() - 2}px; height:#{$(@selectedElement).height() - 2}px; position:absolute; top:#{offset.top}px; left:#{offset.left + 300}px;"
        overlay = document.createElement('div')
        $(overlay).addClass('brackets-highlight')
        $(overlay).attr('data-highlight-index', index)
        $(overlay).attr('style', overlayStyles)
        $("#content").append overlay
        @delay 1, ->
          $(overlay).css('opacity', '1')
        
      return false

refresh = (url) ->
  if(url)
    $('#frame').attr 'src', url