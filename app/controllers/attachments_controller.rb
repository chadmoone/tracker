class AttachmentsController < ApplicationController
  def new
    @issue = Issue.new
    attachment = @issue.attachments.build
    render partial: "attachments/form", locals: { number: params[:number].to_i, attachment: attachment }
  end
end
