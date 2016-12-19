class Api::AttendeesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:index]
  before_action :set_event

  def create
    if params["guest"] != nil
      @guest = params["guest"]
      @a = Guest.create(user: current_user, event: @event, guest_fname: @guest["first_name"], guest_lname: @guest["last_name"])
      if @a
        flash[:success] = "Your guest, #{@guest["first_name"]} #{@guest["last_name"]}, is now added to the event!"
      else
        flash[:fail] = "Your guest, #{@guest["first_name"]} #{@guest["last_name"]}, was not saved to the event!"
      end

      render json: @a
    end
  end

  def destroy
    @guestparam = params["guest"]
    @guest = Guest.where(user: current_user,guest_fname: @guestparam["first_name"], guest_lname: @guestparam["last_name"], id: @guestparam["last_nameid"])
    @guest.destroy_all
    @guests = Guest.where(event: @event, user: current_user)
    render json: @guests
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
