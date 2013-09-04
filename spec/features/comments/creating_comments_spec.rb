require "spec_helper"

feature "Creating comments" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:issue) { FactoryGirl.create(:issue, project: project, user: user) }

  before do
    define_permission!(user, "view", project)
    FactoryGirl.create(:state, name: "Open")

    sign_in_as!(user)
    visit '/'
    click_link project.name
    click_link issue.title
  end

  scenario "Creating a comment" do
    fill_in "Comment", with: "Added a comment!"
    click_button "Add Comment"
    expect(page).to have_content("Comment added.")
    within("#comments") do
      expect(page).to have_content("Added a comment!")
    end
  end

  scenario "Creating an invalid comment" do
    click_button "Add Comment"
    expect(page).to have_content("Comment could not be created.")
    expect(page).to have_content("Body can't be blank")
  end

  scenario "Changing an issue's status" do
    fill_in "Comment", with: "This is a real issue!"
    select "Open", from: "State"
    click_button "Add Comment"
    expect(page).to have_content("Comment added.")
    within("#issue .state") do
      expect(page).to have_content("Open")
    end
  end
end