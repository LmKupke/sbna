class Event < ActiveRecord::Base
  attr_accessor :date_range
  belongs_to :user
end
