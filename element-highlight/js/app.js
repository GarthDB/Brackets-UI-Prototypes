(function() {
  var refresh;

  $(function() {
    refresh();
    return $('#frame').load(function() {
      var element, htmlstring, _i, _len, _ref,
        _this = this;
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
        var index, offset, overlay, overlayStyles;
        index = $(e.target).parent().index();
        _this.selectedElement = _this.elements[index];
        offset = $(_this.selectedElement).offset();
        overlayStyles = '-webkit-box-shadow:0 0 4px #5EA7FC; width:#{$(@selectedElement).width()}px; height:#{$(@selectedElement).height()}px; position:absolute; top:#{offset.top}px; left:#{offset.left + 300}px;';
        overlay = "<div class='brackets-highlight' data-highlight-index='" + index + "' style='" + overlayStyles + "'></div>";
        console.log($("#content").append(overlay));
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
