require 'rails_helper'

RSpec.describe EventRegistrationFormPolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new(name: 'user', password: '1234') }
  let(:admin) { User.new(name: 'admin', password: '123d4', admin: true) }
  let(:event) { Event.new(name: 'test event') }
  let(:event_form) { EventRegistrationForm.new(user_id: user.id, event_id: event.id) }
  let(:event_form_second) { EventRegistrationForm.new(user_id: 234, event_id: event.id) }
  let(:user_scope) { Pundit.policy_scope!(user, Event) }
  let(:admin_scope) { Pundit.policy_scope!(admin, Event) }
  let(:matching_user_scope) { EventRegistrationForm.where(user_id: user.id) }
  let(:matching_admin_scope) { EventRegistrationForm.all }

  context 'scopes' do
    it 'allows a limited subset' do
      expect(user_scope.to_a).to match_array(matching_user_scope)
      expect(admin_scope.to_a).to match_array(matching_admin_scope)
    end
  end

  permissions :index?, :new? do
    it { should permit(admin, event_form) }
    it { should permit(user, event_form) }
  end

  permissions :create? do
    it { should_not permit(admin, event_form) }
    it { should permit(user, event_form) }
  end

  permissions :show? do
    it { should permit(admin, event_form) }
    it { should permit(user, event_form) }
    it { should_not permit(user, event_form_second) }
  end
end
