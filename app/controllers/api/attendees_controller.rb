class Api::AttendeesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:index]
  before_action :set_event

  def create
    if params["guest"] != nil
      @guest = params["guest"]
      @guest_fname = @guest["first_name"]
      @guest_lname = @guest["last_name"]
      @alreadyinvitedguest = Guest.where(event: @event, guest_fname: @guest_fname, guest_lname: @guest_lname)
      if !@alreadyinvitedguest.empty?
        @error = " is already invited!"
      end

      @existingUser = User.where(first_name: @guest_fname, last_name: @guest_lname)
      if !@existingUser.empty?
        @error = " is a user! Let them know about the event"
      end

      if !@alreadyinvitedguest.empty? || !@existingUser.empty?
        render json: { error: @error }, status: 400
      else
        @a = Guest.create(user: current_user, event: @event, guest_fname: @guest_fname, guest_lname: @guest_lname)
        if @a
          flash[:success] = "Your guest, #{@guest_fname} #{@guest_lname}, is now added to the event!"
        else
          flash[:fail] = "Your guest, #{@guest_fname} #{@guest_lname}, was not saved to the event!"
        end
      end
    end
  end

  def destroy
    @guestparam = params["guest"]
    @guest = Guest.where(user: current_user,guest_fname: @guestparam["first_name"], guest_lname: @guestparam["last_name"], id: @guestparam["last_nameid"], event: @event)
    @guest.destroy_all
    @guests = Guest.where(event: @event, user: current_user)
    render json: @guests
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
