class Api::AttendeesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
   before_action :set_event
  def create
    params["guest"].each do |k,v|
      a = Guest.new(user: current_user, event: @event, guest_name: v)
      if a.save
        flash[:success] = "Your guest #{a.guest_name} is now added to the event!"
      else
        flash[:fail] = "Your guest #{a.guest_name} was not saved to the event!"
      end
    end

    redirect_to event_path(@event)
  end

  def update

  end

  private

  def set_event
    @event = Event.find(params[:event_id])
    @attendee = Attendee.create(event: @event, user: current_user)
  end


end
