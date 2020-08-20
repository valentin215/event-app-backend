require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.create(name: 'Test', password: '223') }

  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end

  describe 'Active Record Associations' do
    it { should have_many(:user_custom_attribute_values) }
    it { should have_many(:event_registration_forms) }
    it { should have_many(:events).through(:event_registration_forms) }
  end
end
