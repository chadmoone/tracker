class IssuesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_project
  before_action :set_issue, only: [:show, :edit, :update, :destroy]
  before_action :authorize_create!, only: [:new, :create]
  before_action :authorize_update!, only: [:edit, :update]
  before_action :authorize_delete!, only: :destroy

  def index
    @issues = @project.issues.all
  end

  def show
    @comment = @issue.comments.build
    @states = State.all
    # puts "States: #{@states.map { |s| [s.name, s.id] }}"
  end

  def new
    @issue = @project.issues.build
    @issue.attachments.build
  end

  def create
    @issue = @project.issues.build(issue_params)
    @issue.user = current_user

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
      params.require(:issue).permit(:title, :description, attachments_attributes: [:asset])
    end

    def set_project
      @project = Project.for(current_user).find([params[:project_id]]).first
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found."
      redirect_to root_path
    end

    def set_issue
      @issue = @project.issues.find(params[:id])
    end

    def authorize_create!
      if !current_user.admin? && cannot?("create issues".to_sym, @project)
        flash[:alert] = "You cannot create issues on this project."
        redirect_to @project
      end
    end

    def authorize_update!
      if !current_user.admin? && cannot?("edit issues".to_sym, @project)
        flash[:alert] = "You cannot edit issues on this project."
        redirect_to @project
      end
    end

    def authorize_delete!
      if !current_user.admin? && cannot?("delete issues".to_sym, @project)
        flash[:alert] = "You cannot delete issues from this project."
        redirect_to @project
      end
    end
end
