require 'rails_helper'

RSpec.describe CustomAttribute, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:attribute_type) }
    it { should validate_inclusion_of(:attribute_type).in_array(%w[string boolean]) }
  end

  describe 'Active Record Associations' do
    it { should belong_to(:event).optional }
  end

  describe 'When it is an event custom attribute' do
    subject { CustomAttribute.new(for_event_registration: true) }
    it { should validate_presence_of(:event_id) }
  end
end
