require 'rails_helper'

RSpec.describe CustomAttributePolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new(name: 'ok', password: '1234') }
  let(:custom_attribute) { CustomAttribute.new }
  let(:admin) { User.new(name: 'okd', password: '123d4', admin: true) }
  let(:user_scope) { Pundit.policy_scope!(user, CustomAttribute) }
  let(:admin_scope) { Pundit.policy_scope!(admin, CustomAttribute) }
  let(:matching_admin_scope) { CustomAttribute.all }

  context 'scopes' do
    it 'allows a limited subset' do
      expect(user_scope.to_a).to match_array([])
      expect(admin_scope.to_a).to match_array(matching_admin_scope)
    end
  end

  permissions :index?, :show?, :new?, :create?, :destroy?, :update?, :edit? do
    it { should_not permit(user, custom_attribute) }
    it { should permit(admin, custom_attribute) }
  end
end
