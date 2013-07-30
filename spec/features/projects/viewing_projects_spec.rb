require 'spec_helper'

feature "Viewing projects" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:hidden) { FactoryGirl.create(:project, name: "Hidden") }

  before do
    sign_in_as! user
    define_permission!(user, :view, project)
  end

  scenario "Listing all projects" do
    visit '/'
    expect(page).to_not have_content(hidden.name)

    click_link project.name

    expect(page.current_url).to eql(project_url(project))
  end
end