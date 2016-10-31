class Attendee < ActiveRecord::Base
  validates :guests, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
  validates :event_id, presence: true
  
  belongs_to :user
  belongs_to :event
end
