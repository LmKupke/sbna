class EventsController < ApplicationController
  def index

  end

  def show
    @event = Event.find(params["id"])
  end

  def new
    if current_user.admin? == false
      redirect_to events_path
    else
      @event = Event.new
    end
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event.id)
    else
      flash[:alert] = "Date can not be in the past. If event is today start time can not be in the past"
      redirect_to new_event_path
    end
  end


  COLORS = [
    ["Blue", {style: "background-color: Blue"}],
    ["Black",{:style => "background-color: Black; color: #ffffff"}],
    ["Dark Gray", {:style => "background-color: DarkGray"}],
    ["Dark Red", {style: "background-color: #922429", value: "#922429"}],
    ["Gray", {:style => "background-color: Gray"}],
    ["Green", {style: "background-color: Green"}],
    ["Light Blue", {stye: "background-color: Light Blue"}],
    ["Red", {style: "background-color: Red"}],
    ["Orange", {style: "background-color: Orange"}],
    ["Yellow", {style: "background-color: Yellow"}]
  ]

  private

  def event_params
    params.require(:event).permit(:title, :location, :description, :start, :end, :color)
  end
end
