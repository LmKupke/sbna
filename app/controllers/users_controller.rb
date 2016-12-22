class UsersController < ApplicationController
  def show
    if params["id"] != current_user.id.to_s
      flash[:error] = "Sorry you do not have access to that profile!"
      redirect_to "root"
    end
    @futureEventsAttending = Event.joins("INNER JOIN attendees ON events.id = attendees.event_id").where("attendees.user_id = ? AND events.start >= ?", current_user, Time.zone.now)
    @pastEventsAttended = Event.joins("INNER JOIN attendees ON events.id = attendees.event_id").where("attendees.user_id = ? AND events.start < ?", current_user, Time.zone.now)

    @user_info = current_user
  end
end
