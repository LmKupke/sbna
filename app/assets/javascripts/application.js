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
//= require moment
//= require materialize-sprockets
//= require fullcalendar
//= require fullcalendar/gcal
//= require datetimepicker

$(document).ready(function(){
  $(".button-collapse").sideNav();
  $('#datetimepicker').datetimepicker();
  $('#datetimepicker2').datetimepicker();

  $('#calendar').fullCalendar({
    header: {
      left: 'today prev, next',
      center: 'title',
      right: 'month, agendaWeek, agendaDay'
    },
    selectable: true,
    selectHelper: true,
    editable: true,
    eventLimit: true,
    events: '/api/events',

    select: function(start, end) {
      $.getScript('/api/events/new', function() {
        $("#event_date_range").val(moment(start).format("MM/DD/YYYY HH:mm") + " - " + moment(end).format("MM/DD/YYYY HH:mm"));
        date_range_picker();
        $('.start_hidden').val(moment(start).format("YYYY-MM-DD HH:mm"));
        $('.end_hidden').val(moment(start).format("YYYY-MM-DD HH:mm"));
        $("#calendar").fullCalendar('unselect');
      });
    },
    eventClick: function(event) {
      if (event.id) {
        var pos = window.location.href.search("calendar");
        window.location.href = (window.location.href.slice(0,pos) + "/events/" + event.id);
        return false;
      }
    }
  });
});
