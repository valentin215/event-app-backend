# frozen_string_literal: true

# CustomAttribue class, notice that it can belong_to an event or not.
# Depends if the admin decide to create the custom attribute
# for a User (for_user column) or for an Event (for_event_registration column)
class CustomAttribute < ApplicationRecord
  belongs_to :event, optional: true

  has_many :user_custom_attribute_values, dependent: :nullify
  has_many :event_custom_attribute_values, dependent: :nullify

  validates :name, presence: true, uniqueness: true, case_sensitive: false
  validates :for_user,
            :for_event_registration,
            :required_for_signup,
            :required_for_profile,
            :required_for_event_form, inclusion: { in: [true, false] }
  validates :attribute_type, presence: true, inclusion: { in: %w[string boolean].freeze }
  validates :event_id, presence: true, if: :event_custom_attribute?

  validates :for_user,
            inclusion: { in: [false], message: 'Cannot be for user if the custom attribute is for an event' },
            if: :event_custom_attribute?

  validates :for_event_registration,
            inclusion: { in: [false], message: 'Cannot be for event if the custom attribute is for a user' },
            if: :user_custom_attribute?

  scope :required_for_signup, -> { where(required_for_signup: true) }
  scope :required_for_profile, -> { where(required_for_profile: true) }
  scope :required_for_event_form, -> { where(required_for_event_form: true) }

  private

  def event_custom_attribute?
    for_event_registration
  end

  def user_custom_attribute?
    for_user
  end
end
