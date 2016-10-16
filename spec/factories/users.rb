FactoryGirl.define do
  sequence(:email)    { |n| "person#{n}@example.com" }
  factory :user do
    email
    first_name "Jon"
    last_name "Snow"
    password "direwolfGhost"
    password_confirmation "direwolfGhost"
    phone_number "1234567890"
    zipcode "02115"
    street "11 Durham Street"
    city "Boston"
    state "MA"
    other_address "Unit 2"
  end
end
