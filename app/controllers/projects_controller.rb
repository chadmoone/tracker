class ProjectsController < ApplicationController
  before_action :set_project, only: [:show,
                                     :edit,
                                     :update,
                                     :destroy]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Project was successfully created."
      redirect_to @project
    else
      flash[:alert] = "Project could not be created."
      render action: "new"
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project was successfully updated."  
      redirect_to @project
    else
      flash[:alert] = "Project could not be updated."
      render action: "edit"
    end
  end

  def destroy
    @project.destroy

    flash[:notice] = "Project has been destroyed."

    redirect_to projects_path
  end


  private
    def set_project
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found."
      redirect_to projects_path
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
