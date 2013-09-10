require 'spec_helper'

feature "Watching Issues" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:issue) { FactoryGirl.create(:issue, :project => project, :user => user) }

  before do
    define_permission!(user, "view", project)
    sign_in_as!(user)
    visit '/'
  end

  scenario "Issue watch toggling" do
    click_link project.name
    click_link issue.title
    
    within("#watchers") do
      expect(page).to have_content(user.name)
    end

    click_link "Stop watching this issue"

    expect(page).to have_content("You are no longer watching this issue.")
    within("#watchers") do
      expect(page).to_not have_content(user.name)
    end

    click_link "Watch this issue"
    
    expect(page).to have_content("You are now watching this issue.")
    within("#watchers") do
      expect(page).to have_content(user.name)
    end
  end
end