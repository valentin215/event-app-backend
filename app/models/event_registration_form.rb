class EventRegistrationForm < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :event_custom_attribute_values
end
