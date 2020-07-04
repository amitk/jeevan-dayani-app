# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w'not_feeling_well feeling_better happy'.each { |s| Feedback.find_or_create_by(state: s) }

[{
  name: "pharma_company1",
}].each do |pharma_company|
  PharmaCompany.find_or_create_by(name: pharma_company[:name])
end

[{
  name: "drug1",
  target_ailment: "heart",
  side_effects: ["loss_of_hemoglobin", "sight_weekness"]
}].each { |drug| Drug.find_or_create_by(
  name: drug[:name],
  target_ailment: drug[:target_ailment],
  side_effects: drug[:side_effects],
  pharma_company: PharmaCompany.first,
  )}

[{
  name: "doctor1",
  specialization: "heart_surgon"
}].each { |doctor| Doctor.find_or_create_by(
  name: doctor[:name],
  specialization: doctor[:specialization]
)}

[{
  name: "clinic1",
  country:  "india",
  state:  "maharashtra",
  city: "pune"
}].each { |clinic| Clinic.find_or_create_by(
  name: clinic[:name],
  country: clinic[:country],
  state:  clinic[:state],
  city: clinic[:city]
)}

[{
  name: "patient1",
  age:  24,
  sex:  "F"
}].each do |patient|
  Patient.find_or_create_by(
  name: patient[:name],
  age:  patient[:age],
  sex:  patient[:sex],
) end
