FactoryGirl.define do
  factory :project do
    name "#{Faker::Company.name} #{Faker::Company.suffix}"
    description Faker::Lorem.sentence
  end
end