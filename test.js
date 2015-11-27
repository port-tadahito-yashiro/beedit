select: function(start, end, allDay) {
calendar.fullCalendar('unselect');

 var startDate = $.fullCalendar.formatDate(start, "yyyy-MM-dd HH:mm:ss");
 var endDate = $.fullCalendar.formatDate(end, "yyyy-MM-dd HH:mm:ss");

 $('#start').val(startDate);
 $('#end').val(endDate);
 $('#createEventModal').fadeIn(500);
 //Prevent default form action
 $('#createEventForm').on('submit', function(e){
     return false;
 });

 //Cancel Click close form
 $(document).on('click', '.close, .btnCancel', function(){
   $('#createEventModal').hide('fast');
   document.getElementById("createEventForm").reset();
   calendar.fullCalendar('unselect');
 });

 //Submit event form click
 $('#submitButton').on('click', function(e){
   // We don't want this to act as a link so cancel the link action
   e.preventDefault();
   doSubmit();
 });

   function doSubmit(){
   var title = $('#createEventForm #title').val();
   if (title) {
    var data = $('#createEventForm').serialize();
    alert(data);
         $('#createEventModal').hide('fast');

    $.ajax({
     url: wnm_custom.plugin_url+'/add_events.php',
    data: data,
    type: "POST",
      success: function(json) {
         document.getElementById("createEventForm").reset();
         $('div#myDialogSuccess').fadeIn(500);
         $('div#myDialogSuccess').fadeOut(2000);
      }
      });


      calendar.fullCalendar('renderEvent',
      {
      title: title,
      start: start,
      end: end,
      allDay: allDay
      },
      true // make the event "stick"
      );
      }
      calendar.fullCalendar('unselect');
      };

},
