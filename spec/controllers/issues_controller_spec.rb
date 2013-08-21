require 'spec_helper'

describe IssuesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) } 
  let(:issue) { FactoryGirl.create(:issue, project: project, user: user) } 

  context "standard users" do
    it "cannot access an issue for a project" do
      sign_in user
      get :show, id: issue.id, project_id: project.id

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The project you were looking for could not be found.")
    end

    context "with permission to view the project" do
      before do
        sign_in user
        define_permission!(user, 'view', project)
      end

      def cannot_create_issues!
        response.should redirect_to(project)
        message = "You cannot create issues on this project."
        flash[:alert].should eql(message)
      end

      it "cannot begin to create an issue" do
        get :new, project_id: project.id
        cannot_create_issues!
      end

      it "cannot create an issue without permission" do
        post :create, project_id: project.id
        cannot_create_issues!
      end
    end
  end
end