# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
    title { Faker::Company.bs }
    description { Faker::Lorem.paragraph([1..10].sample) }
    project nil
  end
end
