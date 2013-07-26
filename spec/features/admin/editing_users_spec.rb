require "spec_helper"

feature 'Editing Users' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:admin) { FactoryGirl.create(:admin) }
  
  before do
    sign_in_as! admin
    visit '/'
    click_link 'Admin'
    click_link 'Users'
    click_link user.to_s
    click_link 'Edit User'
  end

  scenario "Updating a user's details" do
    fill_in "Email", with: "newguy@example.com"
    click_button "Update User"

    expect(page).to have_content("User successfully updated.")

    within("h2") do
      expect(page).to have_content("newguy@example.com")
      expect(page).to_not have_content(user.email)
    end
  end

  scenario "Toggling a user's admin ability" do
    check "Administrator"
    click_button 'Update User'

    expect(page).to have_content("User successfully updated.")

    within("h2") do
      expect(page).to have_content("#{user.email} (Admin)")
    end
  end
end