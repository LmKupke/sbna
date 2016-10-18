require "rails_helper"

feature "sign_up", %{
  As an unathenticated user
  I want to sign up for SBNA
  So that I can access go to events
} do
  context "as a prospective user" do
    before(:each) do
      visit root_path
      visit new_user_registration_path
    end
    scenario "I can visit the root path and click a link to create a new
      account" do
      expect(page).to have_css("form#new_user.new_user")
    end

    scenario "I can click a link to create a new account and is taken to the
      new user form" do
      expect(page).to have_css("input#user_first_name")
      expect(page).to have_css("input#user_last_name")
      expect(page).to have_css("input#user_email")
      expect(page).to have_css("input#user_password")
      expect(page).to have_css("input#user_password_confirmation")
    end

    scenario "user unsuccessfully signs up" do
      fill_in("First Name", with: "John")
      fill_in("Last Name", with: "Smith")
      fill_in("Email", with: "abc@gmail.com")
      fill_in("Phone Number", with: "1234567890")
      fill_in("Address Line 1", with: "99 Saint Botolph Street")
      fill_in("Address Line 2", with: "Apartment 2")
      fill_in("Zipcode", with: "11111")
      fill_in("City", with: "Boston")
      click_button('Sign Up')
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("State can't be blank")
    end
    scenario "I will successfully create an account by filling out the form
      correctly" do
      fill_in("First Name", with: "John")
      fill_in("Last Name", with: "Smith")
      fill_in("Email", with: "abc@gmail.com")
      fill_in("Phone Number", with: "1234567890")
      fill_in("Address Line 1", with: "99 Saint Botolph Street")
      fill_in("Address Line 2", with: "Apartment 2")
      fill_in("Zipcode", with: "11111")
      fill_in("City", with: "Boston")
      select('MA', :from => 'State')

      fill_in("Password", with: "password")
      fill_in("Password Confirmation", with: "password")


      click_button('Sign Up')
      expect(page).to have_content("Welcome! You have signed up successfully.")
    end
  end
end
