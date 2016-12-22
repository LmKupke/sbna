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
  $('.collapsible').collapsible();


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
    var eventID = eventIDarray[eventIDarray.length - 1];
    var $count = document.getElementsByClassName("col s12 guest");
    if($count.length < 7) {
      var $countDuplicate = [];
      var $countValues = [];
      for(var i = 0; i < $count.length; i++){
        var $inputchildren = $count[i].children
        if($inputchildren[0].lastElementChild.value === "" || $inputchildren[1].lastElementChild.value === ""){
            Materialize.toast("Please enter a guest's first and last name", 4000, "red")
            return;
        }
        $countValues.push($inputchildren[0].lastElementChild.value + "  " + $inputchildren[1].lastElementChild.value)
      }
      var $countSorted = $countValues.sort();
      for (var i = 0; i < $countSorted.length - 1; i++) {
        if ($countSorted[i + 1] == $countSorted[i]) {
          Materialize.toast("Sorry you have duplicate values", 4000, "red");
          return;
        }
      }
      var a = event.target.parentNode;
      var guest_firstname = a.getElementsByClassName("guest_firstname")[0]
      var guest_firstnameValue = guest_firstname.value
      var guest_lastname = a.getElementsByClassName("guest_lastname")[0]
      var guest_lastnameValue = guest_lastname.value
      var request = $.ajax({
        type: "POST",
        url: "/api/attendees",
        data: { event_id: eventID, guest: {first_name: guest_firstnameValue, last_name: guest_lastnameValue } },
        dataType: "json"
      });

      request.success(function(data) {
        event.target.className = "col s2 waves-effect waves-red btn-flat red deleteGuest";
        event.target.innerHTML = "Delete Guest";
        event.target.id = ""
        guest_lastname.id = data.id
        guest_firstname.id = data.id
        var availability = document.getElementById("spots");
        availability.innerHTML = parseInt(availability.innerHTML - 1)

        var $li = document.createElement("li");
        $li.className = "col s12 guest";

        var $divFname = document.createElement("div");
        $divFname.className = "input-field col s5";
        var $labelFname = document.createElement("label");
        $labelFname.innerHTML = "Guest First Name";
        var $inputFname = document.createElement("input");
        $inputFname.type = "text";
        $inputFname.className = "guest_firstname";

        $divFname.appendChild($labelFname);
        $divFname.appendChild($inputFname);

        var $divLname = document.createElement("div");
        $divLname.className = "input-field col s5";
        var $labelLname = document.createElement("label");
        $labelLname.innerHTML = "Guest Last Name";
        var $inputLname = document.createElement("input");
        $inputLname.type = "text";
        $inputLname.className = "guest_lastname";

        $divLname.appendChild($labelLname);
        $divLname.appendChild($inputLname);

        var $button = document.createElement("button");
        $button.className = "col s2 waves-effect waves-green btn-flat green addGuest";
        $button.innerHTML = "Add Guest";
        $button.id = "addGuest"
        var $ul = document.getElementById("new_guest_list");




        $li.appendChild($divFname);
        $li.appendChild($divLname);
        $li.appendChild($button);
        $ul.appendChild($li);
        Materialize.toast("Your guest, " + guest_firstnameValue + " " + guest_lastnameValue + ", is now added to the event!", 4000, "green");
      })

      request.error(function(data) {
        Materialize.toast(data.responseJSON.error, 4000, "red");
      })

    } else {
      Materialize.toast("Sorry you can only have 6 guests", 4000, "red");
    }
  });

  $(document).on("click",".deleteGuest",function(event){
    event.preventDefault;
    var a = event.target.parentNode;

    var guest_firstname = a.getElementsByClassName("guest_firstname")[0];
    var guest_firstnameValue = guest_firstname.value;
    var guest_firstnameID = guest_firstname.id;

    var availability = document.getElementById("spots");
    var guest_lastname = a.getElementsByClassName("guest_lastname")[0];
    var guest_lastnameValue = guest_lastname.value;
    var guest_lastnameID = guest_lastname.id;
    var eventIDpath = window.location.pathname;
    var eventIDarray = eventIDpath.split("/");
    var eventID = eventIDarray[eventIDarray.length - 1];
    var request = $.ajax({
      type: "DELETE",
      url: "/api/attendees/" + eventID,
      data: {guest: { first_name: guest_firstnameValue, last_name: guest_lastnameValue, first_nameid: guest_firstnameID, last_nameid: guest_lastnameID  }, event_id: eventID}
    })
    request.done(function(data) {
      a.remove();
      Materialize.toast("Your guest, " + guest_firstnameValue + " " + guest_lastnameValue + ", has now been removed from the event.", 4000, "green");
      availability.innerHTML = parseInt(availability.innerHTML) + 1
    })
  });





})
