class IssuesController < ApplicationController
  before_action :set_project
  before_action :set_issue, only: [:show,
                                   :edit,
                                   :update,
                                   :destroy]

  def index
    @issues = @project.issues.all
  end

  def show
  end

  def new
    @issue = @project.issues.build
  end

  def create
    @issue = @project.issues.build(issue_params)

    if @issue.save
      flash[:notice] = "Issue successfully created."
      redirect_to [@project, @issue]
    else
      flash[:alert] = "Issue could not be created."
      render action: :new
    end
  end

  def edit
  end

  def update
    if @issue.update(issue_params)
      flash[:notice] = "Issue successfully updated."
      redirect_to [@project, @issue]
    else
      flash[:alert] = "Issue could not be updated."
      render action: :edit
    end
  end

  def destroy
    @issue.destroy
    flash[:notice] = "Issue has been destroyed."
    redirect_to @project
  end

  private
    def issue_params
      params.require(:issue).permit(:title, :description)
    end

    def set_project
      @project = Project.find([params[:project_id]]).first
    end

    def set_issue
      @issue = @project.issues.find(params[:id])
    end
end