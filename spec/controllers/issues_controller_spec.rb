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
  end
end