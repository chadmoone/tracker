class ProjectsController < ApplicationController

  def index  
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "'#{@project.name}' project was successfully created."
      redirect_to @project
    else
      flash[:alert] = "Could not create project."
      render action: "new"
    end

  end

  private

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
