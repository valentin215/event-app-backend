class UserCustomAttributeValue < ApplicationRecord
  belongs_to :user
  belongs_to :custom_attribute
end
