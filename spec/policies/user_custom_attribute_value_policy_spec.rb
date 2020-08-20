require 'rails_helper'

describe UserCustomAttributeValuePolicy do
  subject { described_class.new(user, custom_attribute_value) }

  let(:custom_attribute_value) { UserCustomAttributeValue.new }

  context 'being a non admin' do
    let(:user) { User.create(admin: false) }

    it { is_expected.to permit_action(%i[show create index]) }
    it { is_expected.to forbid_actions(%i[update destroy]) }
  end

  context 'being an admin' do
    let(:user) { User.create(admin: true) }

    it { is_expected.to permit_actions(%i[index show]) }
  end
end
