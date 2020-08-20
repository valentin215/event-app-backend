require 'rails_helper'

RSpec.describe CustomAttribute, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:attribute_type) }
    it { should validate_inclusion_of(:attribute_type).in_array(%w[string boolean]) }
  end

  describe 'Validations of uniqueness' do
    before do
      subject { described_class.create(name: 'Test') }
      it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }
    end
  end

  context 'Validations for attribute type' do
    it 'it should not be valid with wrong attribute type' do
      custom_attribute = CustomAttribute.create(name: 'ok', attribute_type: 'stin')
      expect(custom_attribute).to_not be_valid
      second_custom_attribute = CustomAttribute.create(name: 'second', attribute_type: 'boolea')
      expect(second_custom_attribute).to_not be_valid
    end
  end

  describe 'Active Record Associations' do
    it { should have_many(:user_custom_attribute_values) }
    it { should have_many(:event_custom_attribute_values) }
    it { should belong_to(:event).optional }
  end

  describe 'When it is an event custom attribute' do
    before { allow(subject).to receive(:event_custom_attribute?).and_return(true) }
    it { should validate_presence_of(:event_id) }
    it { should_not allow_value(true).for(:for_user) }
  end

  describe 'When it is not an event custom attribute' do
    before { allow(subject).to receive(:event_custom_attribute?).and_return(false) }
    it { should_not validate_presence_of(:event_id) }
  end

  describe 'When it is a user custom attribute' do
    before { allow(subject).to receive(:user_custom_attribute?).and_return(true) }
    it { should_not allow_value(true).for(:for_event_registration) }
  end
end
