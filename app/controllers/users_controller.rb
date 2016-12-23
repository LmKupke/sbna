class UsersController < ApplicationController
  def show
    if params["id"] != current_user.id.to_s
      flash[:error] = "Sorry you do not have access to that profile!"
      redirect_to "root"
    end
    @futureEventsAttending = Event.joins("INNER JOIN attendees ON events.id = attendees.event_id").where("attendees.user_id = ? AND events.start >= ?", current_user, Time.zone.now)
    @pastEventsAttended = Event.joins("INNER JOIN attendees ON events.id = attendees.event_id").where("attendees.user_id = ? AND events.start < ?", current_user, Time.zone.now).order('start DESC')
    if params[:page]
      @pastEventsAttended = Kaminari.paginate_array(@pastEventsAttended).page(params[:page]).per(5)
    else
      @pastEventsAttended = Kaminari.paginate_array(@pastEventsAttended).page(params[:page]).per(5)
    end

    # @pastEventsAttended.page(params[:page]).per(2)
    @user_info = current_user
  end
end
