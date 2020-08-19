class EventCustomAttributeValue < ApplicationRecord
  belongs_to :event
  belongs_to :custom_attribute
  belongs_to :event_registration_form

  validates :content, presence: true

  after_save :attribute_type_is_boolean?

  private

  def attribute_type_is_boolean?
    unless required_attribute_is_boolean? && attribute_type_content_is_boolean?
      errors.add(:base, 'Content should be true or false')
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def required_attribute_is_boolean?
    custom_attribute.attribute_type == 'boolean' && custom_attribute.required_for_event_form
  end

  def attribute_type_content_is_boolean?
    %w[true false].include?(content)
  end
end
