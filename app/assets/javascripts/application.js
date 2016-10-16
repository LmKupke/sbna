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
//= require_tree .
//= require materialize-sprockets
//= require moment
//= require fullcalendar
//= require fullcalendar/gcal

$(document).ready(function(){
  $(".button-collapse").sideNav();
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
      $.getScript('/api/events/new', function() {});

      calendar.fullCalendar('unselect');
    }
  });
});
