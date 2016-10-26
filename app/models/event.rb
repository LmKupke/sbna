class Event < ActiveRecord::Base
  attr_accessor :date_range
  belongs_to :user
  mount_uploader :picture, EventPhotoUploader
  validates :title, presence: true
  validates :description, presence: true
  validates :start, presence: true
  validates :end, presence: true,  date: { after_or_equal_to:  :start}
  validates :location, presence: true
end
