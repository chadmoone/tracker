require 'spec_helper'

feature 'Signing Up' do
  scenario 'Successful sign up' do
    visit '/'
    
    within("header") do
      click_link 'Sign up'  
    end

    fill_in 'Email', with: 'user@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")
  end
end