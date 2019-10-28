FactoryBot.define do
  factory :project do
    name { Faker::Team.name }
    category { Faker::Team.sport }
    subcategory { Faker::Team.state }
    description { Faker::Lorem.paragraph }
  end
end
