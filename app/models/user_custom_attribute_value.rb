# frozen_string_literal: true

# Custom attribute value for User where content is the answer
# Content could be a yes or no answer when the admin creates boolean attributes
# A after save checks content and rollback if it's not yes or no for boolean attributes
class UserCustomAttributeValue < ApplicationRecord
  belongs_to :user
  belongs_to :custom_attribute

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
    custom_attribute.attribute_type == 'boolean' &&
      (custom_attribute.required_for_signup || custom_attribute.required_for_profile)
  end

  def attribute_type_content_is_not_boolean?
    %w[yes no].exclude?(content)
  end
end
