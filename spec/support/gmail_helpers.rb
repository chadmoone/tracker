module GmailHelpers
  
  def gmail_connection
    settings = ActionMailer::Base.smtp_settings
    @gmail_connection ||= Gmail.connect(settings[:user_name], settings[:password])
  end
  
  def tracker_emails
    gmail_connection.inbox.find(:unread, :from => "Tracker")
  end
  
  def clear_tracker_emails!
    tracker_emails.map(&:delete!)
  end
end

RSpec.configure do |c|
  c.include GmailHelpers
end