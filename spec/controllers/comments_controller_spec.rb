require 'spec_helper'

describe CommentsController do
  let(:user) { FactoryGirl.create(:user) } 
  let(:project) { FactoryGirl.create(:project) } 

  let(:issue) do
    issue = project.issues.build(title: "State transitions",
                                 description: "Can't be hacked.")
    issue.user = user
    issue.save
    issue
  end

  let(:state) { State.create!(:name => "New") }

  context "a user without permission to set state" do
    before do
      sign_in(user)
    end

    it "cannot transition a state by passing through state_id" do
      post :create, { :comment => { :body => "Hacked!",
                                    :state_id => state.id },
                                    :issue_id => issue.id }
      issue.reload
      issue.state.should eql(nil)
    end
  end
end
