(function() {
  var refresh;

  $(function() {
    refresh();
    return $('#frame').load(function() {
      var element, htmlstring, _i, _len, _ref,
        _this = this;
      this.delay = function(ms, func) {
        return setTimeout(func, ms);
      };
      htmlstring = '<ul>';
      this.elements = $("#frame").contents().find('body *');
      _ref = this.elements;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        element = _ref[_i];
        htmlstring += "<li><a href='#'>" + ($(element).prop('tagName').toLowerCase()) + "</a></li>";
      }
      htmlstring += '</ul>';
      $($('body > aside')[0]).html(htmlstring);
      return $('body > aside a').click(function(e) {
        var existingElement, index, offset, overlay, overlayStyles;
        index = $(e.target).parent().index();
        _this.selectedElement = _this.elements[index];
        existingElement = $('#content .brackets-highlight[data-highlight-index="' + index + '"]');
        if (existingElement.length > 0) {
          $(existingElement).css('opacity', '0');
          _this.delay(200, function() {
            return existingElement.remove();
          });
        } else {
          offset = $(_this.selectedElement).offset();
          overlayStyles = "background: rgba(94,167,255, 0.1);";
          overlayStyles += "box-shadow: 0 0 8px 2px rgba(94,167,255, 0.3), inset 0 0 4px 1px rgba(255,255,255,0.6);";
          overlayStyles += "opacity: 0; -webkit-transition: opacity 0.2s; width:" + ($(_this.selectedElement).width() - 2) + "px; height:" + ($(_this.selectedElement).height() - 2) + "px; position:absolute; top:" + offset.top + "px; left:" + (offset.left + 300) + "px;";
          overlay = document.createElement('div');
          $(overlay).addClass('brackets-highlight');
          $(overlay).attr('data-highlight-index', index);
          $(overlay).attr('style', overlayStyles);
          $("#content").append(overlay);
          _this.delay(1, function() {
            return $(overlay).css('opacity', '1');
          });
        }
        return false;
      });
    });
  });

  refresh = function(url) {
    if (url) {
      return $('#frame').attr('src', url);
    }
  };

}).call(this);
