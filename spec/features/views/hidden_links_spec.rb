require 'spec_helper'

feature 'Hidden Links' do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:project) { FactoryGirl.create(:project) }
  let(:issue) { FactoryGirl.create(:issue, project: project, user: user) } 

  context "anonymous users" do
    scenario 'cannot see the New Project link' do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario 'cannot see the Edit Project link' do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario 'cannot see the Delete Project link' do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end

  context "regular users" do
    before do
      sign_in_as! user
    end

    scenario 'cannot see the New Project link' do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario 'cannot see the Edit Project link' do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario 'cannot see the Delete Project link' do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end

    scenario 'New Issue link is shown to a user with permission' do
      define_permission!(user, "view", project)
      define_permission!(user, "create issues", project)
      visit project_path(project)
      assert_link_for "New Issue"
    end

    scenario 'New Issue link is hidden from a user without permission' do
      define_permission!(user, "view", project)
      visit project_path(project)
      assert_no_link_for "New Issue"
    end

    scenario 'Edit Issue link is shown to a user with permission' do
      issue
      define_permission!(user, "view", project)
      define_permission!(user, "edit issues", project)
      visit project_path(project)
      click_link issue.title
      assert_link_for "Edit Issue"
    end

    scenario 'Edit Issue link is shown to a user with permission' do
      issue
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link issue.title
      assert_no_link_for "Edit Issue"
    end

    scenario 'Delete Issue link is shown to a user with permission' do
      issue
      define_permission!(user, "view", project)
      define_permission!(user, "delete issues", project)
      visit project_path(project)
      click_link issue.title
      assert_link_for "Delete Issue"
    end

    scenario 'Delete Issue link is shown to a user with permission' do
      issue
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link issue.title
      assert_no_link_for "Delete Issue"
    end
  end

  context "admin users" do
    before do
      sign_in_as! admin
    end
    scenario 'can see the New Project link' do
      visit '/'
      assert_link_for "New Project"
    end

    scenario 'can see the Edit Project link' do
      visit project_path(project)
      assert_link_for "Edit Project"
    end

    scenario 'can see the Delete Project link' do
      visit project_path(project)
      assert_link_for "Delete Project"
    end

    scenario 'New Issue link is shown to admins' do
      visit project_path(project)
      assert_link_for "New Issue"
    end

    scenario 'Edit Issue link is shown to admins' do
      issue
      visit project_path(project)
      click_link issue.title
      assert_link_for "Edit Issue"
    end

    scenario 'Delete Issue link is shown to admins' do
      issue
      visit project_path(project)
      click_link issue.title
      assert_link_for "Edit Issue"
    end
  end
end