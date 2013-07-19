require 'spec_helper'

feature "Deleting Issues" do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:issue) { FactoryGirl.create(:issue, project: project) }

  before do
    visit '/'
    click_link project.name
    click_link issue.title
  end

  scenario "Deleting an issue" do
    click_link "Delete Issue"

    expect(page).to have_content("Issue has been destroyed.")
    expect(page.current_url).to eql(project_url(project))
  end
end