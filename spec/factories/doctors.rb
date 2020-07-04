FactoryBot.define do
  factory :doctor do
    name { Faker::Name.name }
    specialization { "Heart Specialist" }
  end
end
