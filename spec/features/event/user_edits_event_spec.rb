require "rails_helper"

feature "admin_updates_book", %{
  As an authenticated admin
  I want to update an so that
  So that others can see it
} do

  context "as an admin user" do
    before(:each) do
      admin = create(:user, role: "admin")
      event = create(:event)
      login_as(admin)
      visit root_path
      visit edit_event_path(event)

    end
    scenario "I can see a edit form for an existing event" do
      expect(page).to have_css("form.edit_event")
    end

    scenario "I fill out a new form correctly" do
      fill_in "Location", with: "555 Saint Botolph Street"
      attach_file 'event[picture]', "#{Rails.root}/spec/support/images/photo.jpg"
        select('Black', :from => 'Color')
      click_button "Update Event"
      expect(page).to have_content("555 Saint Botolph Street")
      expect(page).to have_content("Test Event")
    end

    scenario "I fill out an update form incorrectly" do
      fill_in "Location", with: ""
      attach_file 'event[picture]', "#{Rails.root}/spec/support/images/photo.jpg"
        select('Black', :from => 'Color')
      click_button "Update Event"
      expect(page).to have_css("form.edit_event")
    end
  end
end
