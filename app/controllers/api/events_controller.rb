class Api::EventsController < ApplicationController
  def index
    @events = Event.where(start: params[:start]..params[:end])
    render json: @events
  end
end
