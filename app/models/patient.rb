class Patient < ApplicationRecord

  validates :name, :sex, :age, presence: true

  belongs_to :trial, optional: true
  has_one :feedback
end
