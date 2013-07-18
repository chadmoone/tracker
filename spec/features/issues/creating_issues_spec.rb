require 'spec_helper'

feature 'Creating Issues' do
  before do
    FactoryGirl.create(:project, name: "Internet Explorer")

    visit '/'
    click_link "Internet Explorer"
    click_link "New Issue"
  end

  scenario "Creating an issue" do
    fill_in "Title", with: "No standards-compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Issue"

    expect(page).to have_content("Issue successfully created.")
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