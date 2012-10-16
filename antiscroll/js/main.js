$(function () {

    var waitForFinalEvent = (function () {
        var timers = {};
        return function (callback, ms, uniqueId) {
            if (!uniqueId) {
                uniqueId = "Don't call this twice without a uniqueId";
            }
            if (timers[uniqueId]) {
                clearTimeout(timers[uniqueId]);
            }
            timers[uniqueId] = setTimeout(callback, ms);
        };
    })();




    $('.box-wrap').antiscroll();


    $("#removerow").click(function () {
        $("tr").last().remove();
        $('.box-wrap').antiscroll().refresh();
    });

    $("#addrow").click(function () {
        $(".box-inner table").append("<tr><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td><td>Body</td></tr>");
        $('.box-wrap').antiscroll().refresh();
    });


    $(window).resize(function () {
        waitForFinalEvent(function () {
            $('.box-wrap').antiscroll().refresh();
            //...
        }, 200, "some unique string");
    });
});