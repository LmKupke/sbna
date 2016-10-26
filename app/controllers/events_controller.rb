class EventsController < ApplicationController
  def index

  end

  def calendar
    render "calendar"
  end

  def show
    @event = Event.find(params["id"])
  end

  def new
    if current_user == nil || current_user.admin? == false
      redirect_to root_path
    else
      @event = Event.new
      @url = events_path
      @value = "Create Event"
    end
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event.id)
    else
      # flash[:alert] = "Date can not be in the past. If event is today start time can not be in the past"
      redirect_to new_event_path
    end
  end

  def edit
    if current_user == nil || current_user.admin? == false
      redirect_to root_path
    else
      @event = Event.new
      @url = events_path
      @value = "Update Event"
    end
  end

  def update
    @event = Event.find(params["id"])
    @event.assign_attributes(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      flash[:alert] = "Please add values to each of the forms"
      render :edit
    end
  end

  def destroy
    @event = Event.find(params["id"])
    if current_user == nil || current_user.admin? == false
      flash[:alert] = "Sorry you do not have those priviledges."
      redirect_to root_path
    else
      flash[:success] = "You successfully deleted your event!"
      @event.destroy
      redirect_to calendar_path
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
