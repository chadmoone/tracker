class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_issue

  def create
    @comment = @issue.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment added."
      redirect_to [@issue.project, @issue]
    else
      flash[:alert] = "Comment could not be created."
      render template: "issues/show"
    end
  end

  private
    def find_issue
      @issue = Issue.find(params[:issue_id])
      @project = @issue.project
    end

    def comment_params
      params[:comment].delete(:state_id) unless can?(:"change states", @issue.project)
      params.require(:comment).permit(:body, :state_id)
    end
end
