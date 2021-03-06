require "spec_helper"

feature "Viewing Issues" do
  before do
    user = FactoryGirl.create(:user)
    textmate_2 = FactoryGirl.create(:project, name: "TextMate 2")
    issue = FactoryGirl.create(:issue,
                       project: textmate_2,
                       title: "Make it shiny!",
                       description: "Gradients! Starbursts! Oh my!",
                       user: user)

    internet_explorer = FactoryGirl.create(:project, name: "Internet Explorer")
    issue2 = FactoryGirl.create(:issue,
                       project: internet_explorer,
                       title: "Standards compliance",
                       description: "Isn't a joke.",
                       user: user)

    define_permission!(user, "view", textmate_2)
    define_permission!(user, "view", internet_explorer)
    sign_in_as!(user)
    visit '/'
  end

  scenario "Viewing issues for a given project" do
    click_link "TextMate 2"
    expect(page).to have_content("Make it shiny!")
    expect(page).to_not have_content("Standards compliance")

    click_link "Make it shiny!"
    within("#issue h3") do
      expect(page).to have_content("Make it shiny!")
    end

    expect(page).to have_content("Gradients! Starbursts! Oh my!")
  end
end