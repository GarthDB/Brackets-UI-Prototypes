
  $(function() {
    var waitForFinalEvent;
    waitForFinalEvent = (function() {
      var timers;
      timers = {};
      return function(callback, ms, uniqueId) {
        if (!uniqueId) uniqueId = "Don't call this twice without a uniqueId";
        if (timers[uniqueId]) clearTimeout(timers[uniqueId]);
        return timers[uniqueId] = setTimeout(callback, ms);
      };
    })();
    $("#innerbox").antiscroll();
    $("#removerow").click(function() {
      $("tr").last().remove();
      return $("#innerbox").antiscroll().refresh();
    });
    $("#addrow").click(function() {
      $(".box-inner table").append("<tr><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td></tr>");
      return $("#innerbox").antiscroll().refresh();
    });
    $(window).resize(function() {
      return waitForFinalEvent((function() {
        return $("#innerbox").antiscroll().refresh();
      }), 200, "some unique string");
    });
    $("#innerbox").antiscroll();
    return $('.toggle').click(function() {
      return $('.stuff').toggleClass('too-much');
    });
  });
