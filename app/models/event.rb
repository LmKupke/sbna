class Event < ActiveRecord::Base
  attr_accessor :date_range
  belongs_to :user
  mount_uploader :picture, EventPhotoUploader
  validates :title, presence: true
  validates :description, presence: true
  validates :start, presence: true
  validates :end, presence: true,  date: { after_or_equal_to:  :start}
  validates :location, presence: true
  validates :picture, presence: true

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = self.start.strftime("%Y%m%dT%H%M%S")
    event.dtend = self.end.strftime("%Y%m%dT%H%M%S")
    event.summary = self.title
    event.description = self.description
    event.location = self.location
    event.ip_class = "PUBLIC"
    event.created = self.created_at
    event.last_modified = self.updated_at
    event.uid = event.url = "#{PUBLIC_URL}events/#{self.id}"
    event
  end
end
