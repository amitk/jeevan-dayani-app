class PharmaCompany < ApplicationRecord

  validates :name, presence: true

  has_many  :drugs
end
