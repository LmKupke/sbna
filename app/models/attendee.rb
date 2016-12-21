class Attendee < ActiveRecord::Base
  validates :user_id, presence: true
  validates :event_id, presence: true

  belongs_to :user
  belongs_to :event
  has_many :guests
end
