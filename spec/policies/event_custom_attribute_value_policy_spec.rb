require 'rails_helper'

RSpec.describe EventCustomAttributeValuePolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new(name: 'test user 1', password: '1234') }
  let(:event) { Event.new(name: 'test event') }
  let(:event_custom_attribute_value) { EventCustomAttributeValue.new(event_id: event.id) }
  let(:admin) { User.new(name: 'test admin', password: '123d4', admin: true) }
  let(:user_scope) { Pundit.policy_scope!(user, EventCustomAttributeValue) }
  let(:admin_scope) { Pundit.policy_scope!(admin, EventCustomAttributeValue) }
  let(:matching_admin_scope) { EventCustomAttributeValue.all }

  let(:matching_user_scope) do
    EventCustomAttributeValue.includes(:event_registration_form).where(event_registration_forms: { user_id: user.id })
  end

  context 'scopes' do
    it 'allows a limited subset' do
      expect(user_scope.to_a).to match_array(matching_user_scope)
      expect(admin_scope.to_a).to match_array(matching_admin_scope)
    end
  end

  permissions :index?, :show?, :new? do
    it { should permit(user, event_custom_attribute_value) }
    it { should permit(admin) }
  end

  permissions :create? do
    it { should permit(user, event_custom_attribute_value) }
    it { should_not permit(admin) }
  end

  permissions :destroy?, :update? do
    it { should_not permit(user, event_custom_attribute_value) }
    it { should_not permit(admin) }
  end
end