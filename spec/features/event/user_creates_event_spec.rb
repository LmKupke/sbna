require "rails_helper"

feature "sign_up", %{
  As an unathenticated user
  I want to sign up for SBNA
  So that I can access go to events
} do

  context "as an admin user" do
    before(:each) do
      admin = create(:user, role: "admin")
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
      attach_file 'event[picture]', "#{Rails.root}/spec/support/images/photo.jpg"
        select('Black', :from => 'Color')
      click_button "Create Event"
      expect(page).to have_css("form#new_event")
    end
  end
end
