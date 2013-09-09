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
    expect(page).to have_content("Body can't be blank")
  end

  scenario "Changing an issue's status" do
    define_permission!(user, :"change states", project)
    click_link issue.title
    fill_in "Comment", with: "This is a real issue!"
    select "Open", from: "State"
    click_button "Add Comment"
    expect(page).to have_content("Comment added.")
    within("#issue .state") do
      expect(page).to have_content("Open")
    end

    within("#comments") do
      expect(page).to have_content("State: Open")
    end
  end

  scenario "A user without permission cannot change the state" do
    click_link issue.title
    message = "Expected not to see #comment_state_id, but did."
    find_element = -> { find("#comment_state_id") }
    expect(find_element).to raise_error(Capybara::ElementNotFound), message
  end
end