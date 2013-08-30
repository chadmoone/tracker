require "spec_helper"

feature "Creating comments" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:issue) { FactoryGirl.create(:issue, project: project, user: user) }

  before do
    define_permission!(user, "view", project)

    sign_in_as!(user)
    visit '/'
    click_link project.name
  end

  scenario "Creating a comment" do
    click_link issue.title
    fill_in "Comment", with: "Added a comment!"
    click_button "Add Comment"
    expect(page).to have_content("Comment added.")
    within("#comments") do
      expect(page).to have_content("Added a comment!")
    end
  end

  scenario "Creating an invalid comment" do
    click_link issue.title
    click_button "Add Comment"
    expect(page).to have_content("Comment could not be created.")
    expect(page).to have_content("Body can't be blank.")
  end
end