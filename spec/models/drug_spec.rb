require 'rails_helper'

RSpec.describe Drug, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:target_ailment) }
  end
end
