require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new(name: 'ok', password: '1234') }
  let(:admin) { User.new(name: 'okd', password: '123d4', admin: true) }
  let(:user_scope) { Pundit.policy_scope!(user, User) }
  let(:admin_scope) { Pundit.policy_scope!(admin, User) }

  context 'scopes' do
    it 'allows a limited subset' do
      expect(user_scope.to_a).to match_array(User.where(id: user.id))
      expect(admin_scope.to_a).to match_array(User.all)
    end
  end

  permissions :index? do
    it { should permit(admin) }
    it { should_not permit(user) }
  end

  permissions :show? do
    it { should permit(admin) }
    it { should permit(user) }
  end
end
