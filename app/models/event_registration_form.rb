# frozen_string_literal: true

# Simple Event Registration Form thaht help us to link User and Event
class EventRegistrationForm < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_many :event_custom_attribute_values
end
