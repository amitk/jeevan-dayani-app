class Trial < ApplicationRecord

  belongs_to  :trial_configuration
  has_many    :patients
  has_many    :feedbacks
  validates :phase, presence: true, inclusion: { in: [1, 2, 3, 4], message: "Not a valid phase" }
  validates :status, presence: true
  validates_inclusion_of :status, in: ['active', 'inactive'], message: "Not a valid status"
end
