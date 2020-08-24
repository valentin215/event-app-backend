# frozen_string_literal: true

# Custom attribute value for an event
# Through this class, an admin can retrieve all values
# An after save callback checks if the content is yes or no for custom attributes booleans
class EventCustomAttributeValue < ApplicationRecord
  belongs_to :event
  belongs_to :custom_attribute
  belongs_to :event_registration_form

  validates :content, presence: true

  after_save :attribute_type_is_boolean?

  private

  def attribute_type_is_boolean?
    raise_error if required_attribute_is_boolean? && attribute_type_content_is_not_boolean?
  end

  def raise_error
    errors.add(:base, 'Content should be yes or no')
    raise ActiveRecord::RecordInvalid.new(self)
  end

  def required_attribute_is_boolean?
    custom_attribute.attribute_type == 'boolean' && custom_attribute.required_for_event_form
  end

  def attribute_type_content_is_not_boolean?
    %w[yes no].exclude?(content)
  end
end
