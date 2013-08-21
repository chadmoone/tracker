require "spec_helper"

feature "Seed Data" do
  scenario "The basics" do
    load Rails.root + "db/seeds.rb"
    user = User.where(email: "admin@test.com").first!
    project = Project.where(name: "Tracker Seed Project").first!
  end
end