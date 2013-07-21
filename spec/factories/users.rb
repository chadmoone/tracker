# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    firstname Faker::Name.first_name
    lastname  Faker::Name.last_name
    email     Faker::Internet.email
    password  "password"

    factory :admin do
      admin true
    end
  end
end
