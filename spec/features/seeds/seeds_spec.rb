require "spec_helper"

feature "Seed Data" do
  scenario "The basics" do
    load Rails.root + "db/seeds.rb"

    visit '/users/login'
    fill_in 'Email', with: "admin@test.com"
    fill_in 'Password', with: "password"
    click_button 'Log in'
    expect(page).to have_content('Logged in successfully.')

    click_link "Tracker Seed Project"
    click_link "New Issue"

    fill_in "Title", with: "Comments with state"
    fill_in "Description", with: "Comments always have a state."
    click_button "Create Issue"

    within("#comment_state_id") do
      page.should have_content("New")
      expect(page).to have_content("Open")
      expect(page).to have_content("Closed")
    end
  end
end