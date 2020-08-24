require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { described_class.create(name: 'Test') }

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }
  end

  describe 'Active Record Associations' do
    it { should have_many(:custom_attributes).dependent(:destroy) }
    it { should have_many(:event_registration_forms).dependent(:destroy) }
    it { should have_many(:users).through(:event_registration_forms) }
  end
end
