require 'spec_helper'

feature "Gmail" do
  let!(:alice) { FactoryGirl.create(:user) }
  let!(:me) { FactoryGirl.create(:user, email: "no-reply@willinteractive.com") }
  
  let!(:project) { FactoryGirl.create(:project) }
  let!(:issue) { FactoryGirl.create(:issue, project: project, user: me) }

  before do
    ActionMailer::Base.delivery_method = :smtp

    define_permission!(alice, "view", project)
    define_permission!(me, "view", project)
  end
  
  after do
    ActionMailer::Base.delivery_method = :test
  end

  scenario "Receiving a real-world email" do
    sign_in_as!(alice)
    visit project_issue_path(project, issue)
    fill_in "Comment", :with => "Posting a comment!"
    click_button "Add Comment"

    expect(page).to have_content("Comment added.")
    expect(tracker_emails.count).to eql(1)
    email = tracker_emails.first
    subject = "[tracker] #{project.name} - #{issue.title}"
    expect(email).to have_subject(subject)
    clear_tracker_emails!
  end
end