$(document).ready(function() {
    var select = function(start, end, allDay) {

      console.log('start:' + start);
      console.log('end:' + end);
      console.log('allDay:' + allDay);
        var basicDay = new Date();
        var title = window.prompt("title");
        var data = {event: {name: title,
                            start_at: basicDay.setTime(start),
                            finish_at: basicDay.setTime(end),
                            allDay: allDay}};
        $.ajax({
            type: "POST",
            url: "/event",
            data: data,
            success: function() {
                calendar.fullCalendar('refetchEvents');
            }
        });
        calendar.fullCalendar('unselect');
    };

    var calendar = $('#calendar').fullCalendar({
        events: '/event.json',
        selectable: true,
        selectHelper: true,
        ignoreTimezone: false,
        select: select
    });
});
