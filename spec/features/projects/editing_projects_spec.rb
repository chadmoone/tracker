require 'spec_helper'

feature 'Editing Projects' do
  before do
    FactoryGirl.create(:project, name: "TextMate 2")

    sign_in_as! FactoryGirl.create(:admin)

    visit '/'
    click_link "TextMate 2"
    click_link "Edit Project"
  end

  scenario "Updating a project" do
    fill_in "Name", with: "TextMate 2 beta"
    click_button "Update Project"

    expect(page).to have_content("Project successfully updated.")
  end

  scenario "Updating a project with invalid attributes will not succeed" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content("Project could not be updated.")
  end
end