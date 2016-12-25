class AttendeesController < ApplicationController
  before_action :set_event
  def index
    @attendee = Attendee.create(event: @event, user: current_user)
    redirect_to event_path(@event)
  end

  def destroy
    @attendee = Attendee.where(event: @event, user: current_user)

    @attendee.destroy
    flash[:success] = "You have unregistered for the event and any guests that you registered."
    redirect_to event_path(@event)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
