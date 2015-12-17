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


  $(document).ready(function(){
    $('#date-month').toDate({
        format : 'Y年m月d日 （W）'
    })
  });


  $(document).ready(function() {
    $('#date-time').toDate({
        format : 'H時i分s秒'
    });
  });


  //Cancel Click close form
  // プロジェクトの削除
  $(document).on('click', '#project_delete', function(){
    console.log("押された！");
    $('#projectModal').modal();
  });

  //
  $(document).on('click', '#confirm-in', function(){
    var html = $(this);
    var id = (html.attr('for'));

    $('#projectModal').modal();

    $(document).on('click', '#projectDelete',function(){
      var url = "/super/project/delete/" + id
      // Ajax処理
      $.ajax({
          type: "POST",
          url: url,
          success: function(json) {
          window.location = '/super/project/list'
          },
          error: function(json) {
          window.location = '/super/project/list'
        }
      });
    });
  });


  //
  // ユーザーの削除
  $(document).on('click', '#admin-confirm', function(){

    var html = $(this);
    var id = (html.attr('for'));

    $('#adminModal').modal();

    $(document).on('click', '#adminDelete',function(){
      var url = "/super/admin/delete/" + id
      $.ajax({
        type: "POST",
        url: url,
        success: function(json) {
          window.location = '/super/admin/list'
        },
        error: function(json) {
          window.location = '/super/admin/list'
        }
      });
    });
  });

  //
  //　企業の削除
  $(document).on('click', '#company-confirm', function(){
    var html = $(this);
    var id = (html.attr('for'));

    $('#companyModal').modal();

    $(document).on('click', '#compnayDelete', function(){
      var url = "/super/company/delete/" + id
      $.ajax({
        type: "POST",
        url: url,
        success: function(json) {
          window.location = '/super/company/list'
        },
        error: function(json) {
          window.location = '/super/company/list'
        }
      });
    });
  });

});
