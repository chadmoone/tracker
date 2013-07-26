require 'spec_helper'

feature 'Deleting Users' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:admin) }

  before do
    sign_in_as! admin
    visit '/'
    click_link 'Admin'
    click_link 'Users'
  end

  scenario 'Deleting a user' do
    click_link user.to_s
    click_link 'Delete User'

    expect(page).to have_content("User has been deleted.")
  end

  scenario 'Users cannot delete themselves' do
    click_link admin.to_s
    click_link 'Delete User'

    expect(page).to have_content("You cannot delete yourself!")
  end
end