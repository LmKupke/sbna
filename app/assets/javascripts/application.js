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


  $(document).on("click", "#addGuest" ,function(event){
    event.preventDefault();

    var eventIDpath = window.location.pathname;
    var eventIDarray = eventIDpath.split("/");
    var eventID = eventIDarray[2];
    var $count = document.getElementsByClassName("col s9 guest_text");
    if($count.length < 7) {
      var $countDuplicate = [];
      var $countValues = [];
      for(var i = 0; i < $count.length; i++){
        if($count[i].value === ""){
            Materialize.toast("Please enter a guest's name", 4000, "red")
            return;
        }
        $countValues.push($count[i].value)
      }
      var $countSorted = $countValues.sort();
      for (var i = 0; i < $countSorted.length - 1; i++) {
        if ($countSorted[i + 1] == $countSorted[i]) {
          Materialize.toast("Sorry you have duplicate values", 4000, "red");
          return;
        }
      }
      var a = event.target.parentNode;
      var guest_name = a.getElementsByClassName("guest_text")[0].value
      var request = $.ajax({
        type: "POST",
        url: "/api/attendees",
        data: { event_id: eventID, guest: {guest: guest_name}},
        dataType: "json"
      });

      request.success(function(data) {
        event.target.className = "col s3 waves-effect waves-red btn-flat red deleteGuest";
        event.target.innerHTML = "Delete Guest";
        event.target.id = ""
        a.getElementsByClassName("guest_text")[0].id = data.id

        var $li = document.createElement("li");
        $li.className = "col s12 guest";

        var $label = document.createElement("label");
        $label.className = "col s9";
        $label.innerHTML = "Guest Name";
        var $input = document.createElement("input");
        $input.type = "text";
        $input.className = "col s9 guest_text";

        var $button = document.createElement("button");
        $button.className = "col s3 waves-effect waves-green btn-flat green addGuest";
        $button.innerHTML = "Add Guest";
        $button.id = "addGuest"
        var $ul = document.getElementById("new_guest_list");


        $li.appendChild($label);
        $li.appendChild($input);
        $li.appendChild($button);
        $ul.appendChild($li);
        Materialize.toast("Your guest " + guest_name + " is now added to the event!", 4000, "green");
      })

      request.error(function(data) {
        Materialize.toast("Your guest " + guest_name + " was not saved to the event!", 4000, "red");
      })

    } else {
      Materialize.toast("Sorry you can only have 6 guests", 4000, "red");
    }
  });

  $(document).on("click",".deleteGuest",function(event){
    event.preventDefault;

    var a = event.target.parentNode;

    var guest_name = a.getElementsByClassName("guest_text")[0].value;
    var guest_id = a.getElementsByClassName("guest_text")[0].id;

    var eventIDpath = window.location.pathname;
    var eventIDarray = eventIDpath.split("/");
    var eventID = eventIDarray[2];
    var request = $.ajax({
      type: "DELETE",
      url: "/api/attendees/" + eventID,
      data: {guest: guest_name, event_id: eventID, guest_id: guest_id}
    })
    request.done(function(data) {
      a.remove();
      Materialize.toast("Your guest " + guest_name + " has now been removed from the event.", 4000, "green");

    })
  });





})
