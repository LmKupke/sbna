class Api::EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # before_action :admin_auth, only: [:new, :edit, :update, :destroy]
  def index
    @events = Event.where(start: params[:start]..params[:end])
    render json: @events
  end

  def new
    @event = Event.new
  end

  private
   def set_event
     @event = Event.find(params[:id])
   end

   def admin_auth
     current_user.admin?
   end
end
