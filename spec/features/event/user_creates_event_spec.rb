require "rails_helper"

feature "admin_creates_event", %{
  As an authenticated admin
  I want to create an event
  So that others can see it
} do

  context "as an admin user" do
    before(:each) do
      admin = create(:user, role: "admin", admin: true)
      login_as(admin)
      visit root_path
      visit new_event_path
    end
    scenario "I can see a new form for a new event" do
      expect(page).to have_css("form#new_event")
    end
    scenario "I fill out a new form correctly" do
      fill_in "Title", with: "The First Event!"
      fill_in "Location", with: "555 Saint Botolph Street"
      fill_in "Description", with: "This is a test event"
      fill_in('event[start]', with: DateTime.now)
      fill_in('event[end]', with: DateTime.now + 1.hour)
      fill_in('event[max_participants]', with: 10)
      fill_in('event[price]', with: 10)
      attach_file 'event[picture]', "#{Rails.root}/spec/support/images/photo.jpg"
        select('Black', :from => 'Color')
      click_button "Create Event"
      expect(page).to have_content("555 Saint Botolph Street")
    end

    scenario "I fill out a new form incorrectly" do
      fill_in "Title", with: "The First Event!"
      fill_in "Location", with: ""
      fill_in "Description", with: "This is a test event"
      fill_in('event[start]', with: DateTime.now)
      fill_in('event[end]', with: DateTime.now + 1.hour)
      fill_in('event[max_participants]', with: 10)
      attach_file 'event[picture]', "#{Rails.root}/spec/support/images/photo.jpg"
        select('Black', :from => 'Color')
      click_button "Create Event"
      expect(page).to have_css("form#new_event")
    end
  end
end
