FactoryGirl.define do
  factory :event do
    title "Test Event"
    start DateTime.now
    location "Boston"
    description "This is a test"
    add_attribute :end, DateTime.now + 1.hour
    allDay false
    color "Green"
    max_participants 20
    price 20
    picture do
      File.open(File.join("#{Rails.root}/spec/support/images/photo.jpg"))
    end
    user
  end
end
