class Guest < ActiveRecord::Base
  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :guest_fname, presence: true
  validates :guest_lname, presence: true

  belongs_to :event
  belongs_to :user
  belongs_to :attendee
end
