require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new(name: 'user', password: '1234') }
  let(:admin) { User.new(name: 'admin', password: '123d4', admin: true) }
  let(:event) { Event.new(name: 'test event') }
  let(:user_scope) { Pundit.policy_scope!(user, Event.all) }
  let(:admin_scope) { Pundit.policy_scope!(admin, Event.all) }

  context 'scopes' do
    it 'allows a limited subset' do
      expect(user_scope.to_a).to match_array(user_scope)
      expect(admin_scope.to_a).to match_array(admin_scope)
    end
  end

  permissions :index?, :show? do
    it { should permit(admin, event) }
    it { should permit(user, event) }
  end

  permissions :new?, :create?, :update?, :edit?, :destroy? do
    it { should permit(admin, event) }
    it { should_not permit(user, event) }
  end
end
