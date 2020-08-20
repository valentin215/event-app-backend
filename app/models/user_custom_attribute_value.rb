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
