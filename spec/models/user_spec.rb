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

  # context 'ActiveRecord Associations' do
  #   it 'has many custom attribute values' do
  #     expect(User.reflect_on_association(:user_custom_attribute_values).macro).to be(:has_many)
  #   end
  #   it 'has many event registration forms' do
  #     expect(User.reflect_on_association(:event_registration_forms).macro).to be(:has_many)
  #   end
  # end
end
