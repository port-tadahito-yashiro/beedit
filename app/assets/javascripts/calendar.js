$(document).ready(function() {
    select = function(start, end, allDay) {
      calendar.fullCalendar('unselect');

      var basicDay = new Date();
      $('#start').val(timestampToDatetime(((basicDay.setTime(start)　/ 1000) - 32400)));
      $('#end').val(timestampToDatetime(((basicDay.setTime(end)　/ 1000) - 32400) ));
      $('#calendarModal').modal();
  };

        //Cancel Click close form
        $(document).on('click', '.close, .btnCancel', function(){
          //$('#createEventModal').hide('fast');
          $('#calendarModal').modal('hide');
          document.getElementById("createEventForm").reset();
          calendar.fullCalendar('unselect');
          calendar.fullCalendar('refetchEvents');
        });

        //Submit event form click
        $('#submitButton').on('click', function(e){
          // We don't want this to act as a link so cancel the link action
          e.preventDefault();
          doSubmit();
        });

        // submit実行
        function doSubmit(){
          console.log("submit処理が行われた");
          var title = $('#createEventForm #title').val();
          var start = $('#createEventForm #start').val();
          var end = $('#createEventForm #end').val();
          console.log(start);
          var data = {event: {name: title,
                              start: start,
                              end: end,
                              allDay: 1}};
          // Ajax処理
          $.ajax({
              type: "POST",
              url: "/super/events",
              data: data,
              cache: false,
              success: function(json) {
                  console.log("ajax処理が行われた")
                  document.getElementById("createEventForm").reset();

                  $('#calendarModal').modal('hide');
                  calendar.fullCalendar('refetchEvents');
              }
          });
          calendar.fullCalendar('unselect');
        };

    // イベント選択アップデート処理
    var updateEvent = function(event, revertFunc) {

      var basicDay = new Date();
      // モーダルウィンドウにデフォルト値を設定
      $('#title').val(event.title);
      $('#start').val(timestampToDatetime(((basicDay.setTime(event.start)　/ 1000))));
      $('#end').val(timestampToDatetime(((basicDay.setTime(event.end)　/ 1000))));
      //　モーダルウィンドウ表示
      $('#calendarModal').modal();

      $(document).on('click', '.close, .btnCancel', function(){
        $('#calendarModal').modal('hide');
        document.getElementById("createEventForm").reset();
        calendar.fullCalendar('refetchEvents');
      });

      //Submit event form click
      $('#submitButton').on('click', function(e){
        // We don't want this to act as a link so cancel the link action
        e.preventDefault();
        doSubmit();
      });

      // submitを行った時の処理
      function doSubmit(){
        var title = $('#createEventForm #title').val();
        var start = $('#createEventForm #start').val();
        var end = $('#createEventForm #end').val();
        var url = "/super/events/" + event.id;
        var data = {_method: 'PUT',
                event: {name: title,
                    start: title,
                    end: start,
                    allDay: 1}};
        // Ajax処理
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            success: function(json) {
                document.getElementById("createEventForm").reset();
                $('#calendarModal').modal('hide');
                calendar.fullCalendar('refetchEvents');
            },
            error: revertFunc
        });
        calendar.fullCalendar('unselect');
      };
    };

    // デフォルトで読み込む部分　以下
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

  // タイムスタンプ変換処理
  function timestampToDatetime(timestamp){
    var ts = timestamp;
    var d = new Date( ts * 1000 );
    var year  = d.getFullYear();
    var month = d.getMonth() + 1;
    var day  = d.getDate();
    var hour = ( d.getHours()   < 10 ) ? '0' + d.getHours()   : d.getHours();
    var min  = ( d.getMinutes() < 10 ) ? '0' + d.getMinutes() : d.getMinutes();
    var sec   = ( d.getSeconds() < 10 ) ? '0' + d.getSeconds() : d.getSeconds();
    return( year + '-' + month + '-' + day + ' ' + hour + ':' + min + ':' + sec );
  };
});
