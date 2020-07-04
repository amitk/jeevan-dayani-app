FactoryBot.define do
  factory :feedback do
    state { "happy" }

    association :trial, factory: :trial
    association :patient, factory: :patient
  end
end
