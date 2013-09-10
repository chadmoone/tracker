class Notifier < ActionMailer::Base
  from_address = ActionMailer::Base.smtp_settings[:user_name]
  default from: "Tracker <#{from_address}>"

  def comment_updated(comment, user)
    @comment = comment
    @user = user
    @issue = comment.issue
    @project = @issue.project
    subject = "[tracker] #{@project.name} - #{@issue.title}"
    mail(:to => user.email, :subject => subject)
  end
end
