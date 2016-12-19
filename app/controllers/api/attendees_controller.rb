class Api::AttendeesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:index]
  before_action :set_event

  def create
    if params["guest"] != nil
      @guest = params["guest"]
      @a = Guest.create(user: current_user, event: @event, guest_name: @guest["guest"])
      if @a
        flash[:success] = "Your guest #{@guest["guest"]} is now added to the event!"
      else
        flash[:fail] = "Your guest #{@guest["guest"]} was not saved to the event!"
      end

      render json: @a
    end
  end

  def destroy
    @guest = Guest.find(params[:guest_id])
    @guest.destroy
    @guests = Guest.where(event: @event, user: current_user)
    render json: @guests
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end


end
