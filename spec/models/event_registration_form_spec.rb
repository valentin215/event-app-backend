require 'rails_helper'

RSpec.describe EventRegistrationForm, type: :model do
  describe 'Active Records Associations' do
    it { should belong_to(:event) }
    it { should belong_to(:user) }
    it { should have_many(:event_custom_attribute_values) }
  end
end
