# frozen_string_literal: true

# CustomAttribue class, notice that it can belongs_to event or not.
# Depends if the admin decide to create the custom attribute
# for a User (for_user column) or for an Event (for_event_registration column)
class CustomAttribute < ApplicationRecord
  belongs_to :event, optional: true

  validates_presence_of :name
  validates :for_user,
            :for_event_registration,
            :required_for_signup,
            :required_for_profile,
            :required_for_event_form, inclusion: { in: [true, false] }
  validates :attribute_type, presence: true, inclusion: { in: %w[string boolean] }
  validates :event_id, presence: true, if: -> { :event_custom_attribute? }

  private

  def event_custom_attribute?
    for_event_registration
  end
end
