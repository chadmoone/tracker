require "spec_helper"

feature "Assigning permissions" do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:issue) { FactoryGirl.create(:issue, project: project, user: user) }

  before do
    sign_in_as!(admin)

    click_link "Admin"
    click_link "Users"
    click_link user.to_s
    click_link "Permissions"
  end

  scenario "Viewing a project" do
    check_permission_box "view", project

    click_button "Update"
    click_link "Log out"

    sign_in_as!(user)
    expect(page).to have_content(project.name)
  end

  scenario "Creating issues for a project" do
    check_permission_box "view", project
    check_permission_box "create_issues", project
    click_button "Update"
    click_link "Log out"

    sign_in_as!(user)
    click_link project.name
    click_link "New Issue"
    fill_in "Title", with: "Shiny!"
    fill_in "Description", with: "Make it so!"
    click_button "Create"

    expect(page).to have_content("Issue successfully created.")
  end

  scenario "Updating an issue for a project" do
    check_permission_box "view", project
    check_permission_box "edit_issues", project
    click_button "Update"
    click_link "Log out"

    sign_in_as!(user)
    click_link project.name
    click_link issue.title
    click_link "Edit Issue"
    fill_in "Title", with: "Really Shiny!"
    click_button "Update Issue"

    expect(page).to have_content("Issue successfully updated.")
  end

  scenario "Deleting an issue for a project" do
    check_permission_box "view", project
    check_permission_box "delete_issues", project
    click_button "Update"
    click_link "Log out"

    sign_in_as!(user)
    click_link project.name
    click_link issue.title
    click_link "Delete Issue"

    expect(page).to have_content("Issue has been destroyed.")
  end

  scenario "Changing states for an issue" do
    FactoryGirl.create(:state, name: "Open")
    check_permission_box "view", project
    check_permission_box "change_states", project
    click_button "Update"
    click_link "Log out"
    sign_in_as!(user)
    click_link project.name
    click_link issue.title
    fill_in "Comment", :with => "Opening this issue."
    select "Open", :from => "State"
    click_button "Add Comment"
    page.should have_content("Comment added.")
    within("#issue .state") do
      page.should have_content("Open")
    end
  end
end