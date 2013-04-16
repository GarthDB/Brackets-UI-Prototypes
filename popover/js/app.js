(function() {
  $(function() {
    return $('#switch').click(function() {
      $('#popover-container').toggleClass('popoverAbove');
      $('#popover-container').toggleClass('popoverBelow');
      return false;
    });
  });

}).call(this);
