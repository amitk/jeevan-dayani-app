class Clinic < ApplicationRecord

  validates :name, :country, :state, :city, presence: true

  has_and_belongs_to_many :doctors
end
