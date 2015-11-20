$(document).ready(function() {
    var select = function(start, end, allDay) {

        var basicDay = new Date();
        var title = window.prompt("タイトルを入力してください");
        var data = {event: {name: title,
                            start: basicDay.setTime(start),
                            end: basicDay.setTime(end),
                            allDay: 1}};

                            console.log('start:' + start);
                            console.log('end:' + end);
                            console.log('allDay:' + allDay);
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
        //カレンダーの形の種類
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,basicWeek,basicDay'
        },
        defaultView: 'basicWeek',
        // イベントを表示する
        events:
        '/event.json',
        selectable: true,
        selectHelper: true,
        ignoreTimezone: false,
        select: select
    });
});
