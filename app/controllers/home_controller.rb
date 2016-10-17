class HomeController < ApplicationController
  def index
    @upcomingEvents = Event.where("start >= ?", Time.now).order(start: :asc).limit(3)
  end
end
