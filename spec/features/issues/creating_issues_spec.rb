require 'spec_helper'

feature 'Creating Issues' do
  before do
    project = FactoryGirl.create(:project)
    @user = FactoryGirl.create(:user)
    define_permission!(@user, "view", project)
    define_permission!(@user, "create issues", project)
    sign_in_as!(@user)

    visit '/'
    click_link project.name
    click_link "New Issue"

    within("h2") do
      expect(page).to have_content("New Issue")
    end
  end

  scenario "Creating an issue" do
    fill_in "Title", with: "No standards-compliance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Issue"

    expect(page).to have_content("Issue successfully created.")

    within "#issue .creator" do
      expect(page).to have_content("#{@user.name}")
    end
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

  scenario "Creating an issue with attachments", js: true do
    fill_in "Title", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attribute"

    attach_file "File #1", "spec/fixtures/speed.txt"

    click_link "Add another file"
    attach_file "File #2", "spec/fixtures/tony.jpg"

    click_link "Add another file"
    attach_file "File #3", "spec/fixtures/gettysburg.docx"

    click_button "Create Issue"

    expect(page).to have_content("Issue successfully created.")

    within "#issue .attachments" do
      expect(page).to have_content("speed.txt")
      expect(page).to have_content("tony.jpg")
      expect(page).to have_content("gettysburg.docx")
    end
  end
end