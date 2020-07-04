FactoryBot.define do
  factory :drug do
    name { Faker::Name.name }
    target_ailment { ["heart", "brain", "head", "limbs"].sample }
    side_effects { ["hair_loss", "fatigue", "chest_pain"] }

    association :pharma_company, factory: :pharma_company
  end
end
