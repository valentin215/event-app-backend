require 'rails_helper'

RSpec.describe EventCustomAttributeValue, type: :model do
  let(:user) { User.create(name: 'Test user', password: 'test pw', admin: false) }
  let(:event) { Event.create(name: 'test event') }

  let(:form) { EventRegistrationForm.create(event_id: event.id, user_id: user.id) }

  let(:custom_attribute) do
    CustomAttribute.create(event_id: event.id,
                           name: 'test',
                           for_event_registration: true,
                           required_for_event_form: true,
                           attribute_type: 'boolean')
  end

  subject do
    described_class.create(event_id: event.id,
                           event_registration_form_id: form.id,
                           custom_attribute_id: custom_attribute.id,
                           content: 'true')
  end

  describe 'Validations' do
    it { should validate_presence_of(:content) }
  end

  describe 'Active Record Associations' do
    it { should belong_to(:event) }
    it { should belong_to(:custom_attribute) }
    it { should belong_to(:event_registration_form) }
  end

  describe 'Valid object after callback save' do
    it do
      subject.run_callbacks :save
      expect(subject).to be_valid
    end
  end

  describe 'Callbacks' do
    it { is_expected.to callback(:attribute_type_is_boolean?).after(:save) }
  end
end
