require 'rails_helper'

RSpec.describe UserCustomAttributeValue, type: :model do
  let(:user) { User.create(name: 'Test user', password: 'test pw', admin: false) }
  let(:event) { Event.create(name: 'test event') }

  let(:form) { EventRegistrationForm.create(event_id: event.id, user_id: user.id) }

  let(:custom_attribute) do
    CustomAttribute.create(event_id: nil,
                           name: 'test',
                           for_event_registration: false,
                           required_for_event_form: false,
                           for_user: true,
                           required_for_profile: true,
                           required_for_signup: false,
                           attribute_type: 'boolean')
  end

  describe 'Validations' do
    it { should validate_presence_of(:content) }
  end

  describe 'Active Record Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:custom_attribute) }
  end

  describe 'Callbacks' do
    it { is_expected.to callback(:attribute_type_is_boolean?).after(:save) }
  end

  describe 'Valid object after callback save' do
    subject do
      described_class.create(user_id: user.id,
                             custom_attribute_id: custom_attribute.id,
                             content: 'yes')
    end
    it do
      subject.run_callbacks :save
      expect(subject).to be_valid
    end
  end

  describe 'Valid object after callback second test' do
    subject do
      described_class.create(user_id: user.id,
                             custom_attribute_id: custom_attribute.id,
                             content: 'no')
    end
    it do
      subject.run_callbacks :save
      expect(subject).to be_valid
    end
  end

  describe 'Valid object after callback third test' do
    subject do
      described_class.new(user_id: user.id,
                          custom_attribute_id: custom_attribute.id,
                          content: 'ndadazdo')
    end
    it do
      expect(subject.save).to eq(false)
    end
  end
end
