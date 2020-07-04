class Drug < ApplicationRecord

  validates :name, :target_ailment, presence: true

  belongs_to :pharma_company
  has_many  :trial_configurations
end
