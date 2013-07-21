require 'spec_helper'

feature "Editing Issues" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:issue) { FactoryGirl.create(:issue, project: project, user: user) }

  before do
    sign_in_as! user
    visit '/'
    click_link project.name
    click_link issue.title
    click_link "Edit Issue"
  end

  scenario "Updating an issue" do
    fill_in "Title", with: "Make it really shiny!"
    click_button "Update Issue"

    expect(page).to have_content("Issue successfully updated.")

    within("#issue h2") do
      expect(page).to have_content("Make it really shiny!")
    end

    expect(page).to_not have_content(issue.title)
  end

  scenario "Updating an issue with invalid information" do
    fill_in "Title", with: ""
    click_button "Update Issue"

    expect(page).to have_content("Issue could not be updated.")
  end
end