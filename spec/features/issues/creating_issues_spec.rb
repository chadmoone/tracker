require 'spec_helper'

feature 'Creating Issues' do
  before do
    project = FactoryGirl.create(:project)
    @user = FactoryGirl.create(:user)

    visit '/'
    click_link project.name
    click_link "New Issue"

    message = "You need to log in or sign up before continuing."
    expect(page).to have_content(message)

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"

    within("h2") do
      expect(page).to have_content("New Issue")
    end
  end

  scenario "Creating an issue" do
    fill_in "Title", with: "No standards-compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Issue"

    expect(page).to have_content("Issue successfully created.")

    within "#issue #creator" do
      expect(page).to have_content("Created by #{@user.name}")
    end
  end

  scenario "Creating an issue without valid attributes fails" do
    click_button "Create Issue"
    expect(page).to have_content("Issue could not be created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "Description must be longer than 10 characters" do
    fill_in "Title", with: "No standards-compliance"
    fill_in "Description", with: "it sucks"
    click_button "Create Issue"

    expect(page).to have_content("Issue could not be created.")
    expect(page).to have_content("Description is too short")
  end
end