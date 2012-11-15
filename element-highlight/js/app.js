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
        overlayStyles = "outline: 4px solid rgba(94, 167, 255, 1); box-shadow: 0 0 30px #42adfc; width:" + ($(_this.selectedElement).width() - 2) + "px; height:" + ($(_this.selectedElement).height() - 2) + "px; position:absolute; top:" + offset.top + "px; left:" + (offset.left + 300) + "px;";
        overlay = "<div class='brackets-highlight' data-highlight-index='" + index + "' style='" + overlayStyles + "'></div>";
        $("#content").append(overlay);
        console.log(overlay);
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
