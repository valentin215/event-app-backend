require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Active Record Associations' do
    it { should have_many(:custom_attributes) }
    it { should have_many(:event_registration_forms) }
    it { should have_many(:users).through(:event_registration_forms) }
  end
end
