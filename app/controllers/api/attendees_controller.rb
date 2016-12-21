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
        @error = "Your guest, #{@guest_fname} #{@guest_lname}, was not saved to the event. #{@guest_fname} #{@guest_lname} is already invited!"
      end


      @existingUser = User.where(first_name: @guest_fname, last_name: @guest_lname)
      if !@existingUser.empty?
        @error = "Your guest, #{@guest_fname} #{@guest_lname}, was not saved to the event. #{@guest_fname} #{@guest_lname} is a member! Let them know about the event."
      end

      if !@alreadyinvitedguest.empty? || !@existingUser.empty?
        render json: { error: @error }, status: 400
      else
        @a = Guest.new(user: current_user, event: @event, guest_fname: @guest_fname, guest_lname: @guest_lname)
        if @a.save
          flash[:success] = "Your guest, #{@guest_fname} #{@guest_lname}, is now added to the event!"
          render json: @a
        else
          render json: { error: @a.errors.full_messages }, status: 400
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
