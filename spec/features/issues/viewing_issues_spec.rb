require "spec_helper"

feature "Viewing Issues" do
  before do
    textmate_2 = FactoryGirl.create(:project, name: "TextMate 2")
    FactoryGirl.create(:issue,
                       project: textmate_2,
                       title: "Make it shiny!",
                       description: "Gradients! Starbursts! Oh my!")

    internet_explorer = FactoryGirl.create(:project, name: "Internet Explorer")
    FactoryGirl.create(:issue,
                       project: internet_explorer,
                       title: "Standards compliance",
                       description: "Isn't a joke.")

    visit '/'
  end

  scenario "Viewing issues for a given project" do
    click_link "TextMate 2"
    expect(page).to have_content("Make it shiny!")
    expect(page).to_not have_content("Standards compliance")

    click_link "Make it shiny!"
    within("#issue h2") do
      expect(page).to have_content("Make it shiny!")
    end

    expect(page).to have_content("Gradients! Starbursts! Oh my!")
  end
end