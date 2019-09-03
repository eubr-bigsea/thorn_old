FactoryBot.define do
  factory :team do
    project { create(:project) }
    name { Faker::Company.name }
    description { Faker::Lorem.paragraph }
  end
end
