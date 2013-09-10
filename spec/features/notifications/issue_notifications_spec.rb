require "spec_helper"

feature "Issue Notifications" do
  let!(:alice) { FactoryGirl.create(:user, email: "alice@example.com") }
  let!(:bob) { FactoryGirl.create(:user, email: "bob@example.com") }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:issue) { FactoryGirl.create(:issue, project: project, user: alice) }

  before do
    ActionMailer::Base.deliveries.clear

    define_permission!(alice, "view", project)
    define_permission!(bob, "view", project)

    sign_in_as! bob
    visit '/'
  end

  scenario "Issue owner receives notifications about comments" do
    click_link project.name
    click_link issue.title
    fill_in "Comment", :with => "Is it out yet?"
    click_button  "Add Comment"
    email = find_email!(alice.email)
    subject = "[tracker] #{project.name} - #{issue.title}"
    expect(email.subject).to include(subject)
    click_first_link_in_email(email)
    within("#issue h3") do
      expect(page).to have_content(issue.title)
    end
  end

  scenario "Comment authors are automatically subscribed to an issue" do
    click_link project.name
    click_link issue.title
    fill_in "Comment", :with => "Is it out yet?"
    click_button "Add Comment"
    page.should have_content("Comment added.")
    find_email!(alice.email)
    click_link "Log out"
    reset_mailer
    sign_in_as!(alice)
    click_link project.name
    click_link issue.title
    fill_in "Comment", :with => "Not yet!"
    click_button "Add Comment"
    page.should have_content("Comment added.")
    find_email!(bob.email)
    lambda { find_email!(alice.email) }.should raise_error
  end
end