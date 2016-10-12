class HomeController < ApplicationController
  def index
    @upcomingEvents = Event.where("start_date >= ?", Time.now).order(start_date: :asc).limit(3)
  end
end
