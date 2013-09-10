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


end