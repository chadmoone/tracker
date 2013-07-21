require 'spec_helper'

feature 'Signing In' do
  scenario 'Signin in via form' do
    user = FactoryGirl.create(:user, password: 'password', password_confirmation: 'password')
    visit '/'
    click_link 'Log in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
  end
end