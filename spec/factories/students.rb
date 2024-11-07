FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
    subject { "Math" }
    marks { rand(0..100) }
    association :user
  end
end
  