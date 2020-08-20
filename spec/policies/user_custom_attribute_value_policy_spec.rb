require 'rails_helper'

RSpec.describe UserCustomAttributeValuePolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new(name: 'ok', password: '1234') }
  let(:user_custom_attribute_value) { UserCustomAttributeValue.new(user_id: user.id) }
  let(:admin) { User.new(name: 'okd', password: '123d4', admin: true) }
  let(:user_scope) { Pundit.policy_scope!(user, UserCustomAttributeValue) }
  let(:admin_scope) { Pundit.policy_scope!(admin, UserCustomAttributeValue) }

  context 'scopes' do
    it 'allows a limited subset' do
      matching_user_scope = UserCustomAttributeValue.where(user_id: user.id)
      matching_admin_scope = UserCustomAttributeValue.all

      expect(user_scope.to_a).to match_array(matching_user_scope)
      expect(admin_scope.to_a).to match_array(matching_admin_scope)
    end
  end

  permissions :index?, :show? do
    it { should permit(user, user_custom_attribute_value) }
    it { should permit(admin, user_custom_attribute_value) }
  end

  permissions :create? do
    it { should permit(user, user_custom_attribute_value) }
    it { should_not permit(admin, user_custom_attribute_value) }
  end
end
