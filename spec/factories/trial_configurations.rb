FactoryBot.define do
  factory :trial_configuration do
    name { Faker::Name.name }

    association :drug, factory: :drug
    association :doctor, factory: :doctor
    association :clinic, factory: :clinic
  end
end
