class Notifier < ActionMailer::Base
  default from: "tracker@example.com"

  def comment_updated(comment, user)
    @comment = comment
    @user = user
    @issue = comment.issue
    @project = @issue.project
    subject = "[tracker] #{@project.name} - #{@issue.title}"
    mail(:to => user.email, :subject => subject)
  end
end
