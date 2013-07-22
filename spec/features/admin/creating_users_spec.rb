require "spec_helper"

feature 'Creating Users' do
  let!(:admin) { FactoryGirl.create(:admin) }

  before do
    sign_in_as!(admin)
    visit '/'
    click_link 'Admin'
    click_link 'Users'
    click_link 'New User'
  end

  scenario 'Creating a new user' do
    fill_in 'Email', with: 'newbie@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Create User'
    expect(page).to have_content("User successfully created.")
  end

  scenario 'Creating an admin user' do
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'password'
    check 'Administrator'
    click_button 'Create User'
    expect(page).to have_content("User successfully created.")
    expect(page).to have_content("admin@example.com (Admin)")
  end
end