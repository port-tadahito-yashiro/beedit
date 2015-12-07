// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require Chart.min.js
//= require jquery.todate.js
//= require twitter/bootstrap
//= require jquery.turbolinks
//= require turbolinks
//= require moment
//= require bootstrap-datetimepicker
//= require fullcalendar
//= require_tree .

//var data = {'data-date-format': 'YYYY-MM-DD hh:mm:ss' };
$(function(){
  //$('.datepicker4').attr(data);
  $('.datepicker4').datetimepicker({
    format : 'YYYY/MM/DD hh:mm:ss'
  });


  //Submit event form click
  $(document).on('click','#deleteAdmin', function(){
    var adminId = $('#deleteAdmin').attr("foo");

    console.log(adminId);
  });


  $(document).ready(function() {
    $('#date').toDate({
        format : 'Y年m月d日 （W） h時i分s秒'
    });

});


  //Cancel Click close form
  $(document).on('click', '#project_delete', function(){
    console.log("押された！");
    $('#projectModal').modal();
  });

});


// デリート処理
