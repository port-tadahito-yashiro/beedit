$(document).ready(function() {
    var select = function(start, end, allDay) {

        var basicDay = new Date();
        var title = window.prompt("タイトルを入力してください");
        var data = {event: {name: title,
                            start: ((basicDay.setTime(start)　/ 1000) - 32400),
                            end: ((basicDay.setTime(end)　/ 1000) - 32400),
                            allDay: 1}};

                            // 32400を引くのは日本時間に合わせるため
                            console.log('start:' + (basicDay.setTime(start)　/ 1000) - 32400);
                            console.log('end:' + (basicDay.setTime(end) / 1000) - 32400);
                            console.log('allDay:' + allDay);
                            console.log('calendar:' + calendar);

        $.ajax({
            type: "POST",
            url: "/super/events",
            data: data,
            success: function() {
                calendar.fullCalendar('refetchEvents');
            }
        });
        calendar.fullCalendar('unselect');
    };

    var updateEvent = function(event, revertFunc) {
    var basicDay = new Date();
    var title = window.prompt("Edit title", event.title);
    var url = "/super/events/" + event.id;
    var data = {_method: 'PUT',
            event: {name: title,
                start: ((basicDay.setTime(event.start) / 1000) - 32400),
                end: ((basicDay.setTime(event.end) / 1000) - 32400),
                allDay: 1}};

                console.log('aaaaaaa');

    $.ajax({
        type: "POST",
        url: url,
        data: data,
        success: function() {
        calendar.fullCalendar("refetchEvents");
        },
        error: revertFunc
    });
    };

    var calendar = $('#calendar').fullCalendar({
        //カレンダーの形の種類
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },

        // jQuery UI theme
        theme: false,

        // 土曜、日曜を表示
        weekends: true,

        // 週モード (fixed, liquid, variable)
        weekMode: 'fixed',

        // 週数を表示
        weekNumbers: false,

        // 初期表示view
        defaultView: 'month',

        // 終日スロットを表示
        allDaySlot: true,



        // 終日スロットのタイトル
        allDayText: '終日',

        // スロットの時間の書式
        axisFormat: 'H(:mm)',

        // 時間の書式
        //timeFormat: 'H(:mm)',

        // 列の書式
        //columnFormat: {
        //  month: 'ddd',    // 月
        //  week: "d'('ddd')'", // 7(月)
        //  day: "d'('ddd')'" // 7(月)
        //},

        // タイトルの書式
        titleFormat: {
        //    month: 'YYYY年M月',                             // 2013年9月
        //    week: "YYYY年M月D日{ ～ }{[YYYY年]}{[M月]D日}", // 2013年9月7日 ～ 13日
        //    day: "YYYY年M月D日'('DDD')'"                  // 2013年9月7日(火)
        },

        // ボタン文字列
        buttonText: {
        //    prev:     '&lsaquo;', // <
        //    next:     '&rsaquo;', // >
        //    prevYear: '&laquo;',  // <<
        //    nextYear: '&raquo;',  // >>
            today:    '今日',
            month:    '月',
            week:     '週',
            day:      '日'
        },


        // 月名称
        monthNames: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
        // 月略称
        monthNamesShort: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
        // 曜日名称
        dayNames: ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日'],
        // 曜日略称
        dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],


        // スロットの分
        slotMinutes: 15,
        // イベントを表示する
        events: '/super/events.json',
        selectable: true,
        selectHelper: true,
        ignoreTimezone: false,
        editable: true,
        select: select,
        eventClick: updateEvent,
        eventResize: updateEvent,
        eventDrop: updateEvent
    });

});
