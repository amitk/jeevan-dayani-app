FactoryBot.define do
  factory :patient do
    name { Faker::Name.name }
    age { Faker::Number.between(0, 100) }
    sex { ["M", "F"].sample }

    association :trial, factory: :trial
  end
end
