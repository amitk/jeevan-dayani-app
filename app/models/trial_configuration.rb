class TrialConfiguration < ApplicationRecord

  belongs_to  :doctor
  belongs_to  :clinic
  belongs_to  :drug
  has_many    :trials
end
