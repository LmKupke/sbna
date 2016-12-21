class Attendee < ActiveRecord::Base
  validates :user_id, presence: true
  validates :event_id, presence: true
  validate :eventavailabilty?

  belongs_to :user
  belongs_to :event
  has_many :guests

  def eventavailabilty?

    if self.event.participants.length + self.event.guests.length + 1 > self.event.max_participants
      errors.add(:availability, "Sorry there is no availability left.")
      return false
    end
    return true
  end
end
