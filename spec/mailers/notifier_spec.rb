require "spec_helper"

describe Notifier do
   context "comment_updated" do
      let!(:project) { FactoryGirl.create(:project) }

      let!(:issue_owner) { FactoryGirl.create(:user) }
      let!(:issue) { FactoryGirl.create(:issue,
                                        project: project,
                                        user: issue_owner) }

      let!(:commenter) { FactoryGirl.create(:user) }
      let!(:comment) { FactoryGirl.create(:comment,
                                          issue: issue,
                                          user: commenter) }

      let!(:email) do
         Notifier.comment_updated(comment, issue_owner)
      end

      it "sends out an email notification about a new comment" do
        expect(email).to deliver_to(issue_owner.email)
        title = "#{issue.title} for #{project.name} has been updated."
        expect(email).to have_body_text(title)
        expect(email).to have_body_text("#{comment.user.email} wrote:")
        expect(email).to have_body_text(comment.body)
      end
  end
end
