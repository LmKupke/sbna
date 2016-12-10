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
  $(".dropdown-button.navside").dropdown({hover: true});
  $(".dropdown-button").dropdown({hover: true});
  $('.modal-trigger').leanModal();
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

  $('#guestNum').change(function(){
     var number = parseInt($('#guestNum').val());
     var $form = document.getElementById("new_attendee");
     while ($form.hasChildNodes()) {
       $form.removeChild($form.lastChild);
     }

    var eventIDpath = window.location.pathname;
    var eventIDarray = eventIDpath.split("/");
    var eventID = eventIDarray[2];
     for (i=0;i<number;i++){
       var label = document.createTextNode( "Guest " + (i+1) + " Name");
       $form.appendChild(label);
       var input = document.createElement("input");
       input.type = "text";
       input.name = "guest[guest" + i + "]";
       $form.appendChild(input);
     }
     var $submission = $form.appendChild(document.createElement("input"));
     $submission.type = "submit";
     $submission.value = "Register"
     $submission.name = "commit";
     $submission.className = "modal-action modal-close green register-button col push-s9 waves-effect waves-green btn-flat";
     var input = document.createElement("input");
     input.type= "hidden";
     input.value = eventID;
     input.name = "event_id";
     $form.appendChild(input);
     $submission.on('click', function attendeeSubmit(event, eventID) {
       event.preventDefault();
       var request = $.ajax({
         type: "POST",
         url: "/api/attendees",
         dataType: "json"
       });
     });
     $form.appendChild($submission);
  });
})

// function attendeeSubmit(event,eventID)
//   // event.preventDefault();
//   // var request = $.ajax({
//   //   type: "POST",
//   //   url: "/api/attendees",
//   //   dataType: "json"
  // });

  // request.fail(function(response){
  //   alert(response.responseJSON.message);
  // });

  // request.done(function(data) {
  //
  // });
// }
