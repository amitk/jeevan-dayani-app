FactoryBot.define do
  factory :trial do
    name { Faker::Name.name }
    phase { 1 }
    status { "active" }
    association :trial_configuration, factory: :trial_configuration
  end
end
