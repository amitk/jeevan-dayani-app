FactoryBot.define do
  factory :clinic do
    name { Faker::Name.name }
    country { Faker::Address.country }
    state { Faker::Address.state }
    city { Faker::Address.city }
  end
end
