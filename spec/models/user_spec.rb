require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    it 'is not valid whithout a name' do
      user = User.new(name: nil, password: '123456')
      expect(user).to_not be_valid
    end
    it 'is not valid whithout a password' do
      user = User.new(name: 'Test Name', password: '')
      expect(user).to_not be_valid
    end
  end

  describe 'Active Record Associations' do
    it { should have_many(:user_custom_attribute_values) }
    it { should have_many(:event_registration_forms) }
    it { should have_many(:events).through(:event_registration_forms) }
  end
end
