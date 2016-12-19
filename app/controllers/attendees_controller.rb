class AttendeesController < ApplicationController
  before_action :set_event
  def index
    @attendee = Attendee.create(event: @event, user: current_user)
    redirect_to event_path(@event)
  end

  def destroy

  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
