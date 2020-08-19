# frozen_string_literal: true

# Simple User class
class User < ApplicationRecord
  # has_many :user_custom_attribute_values
  # has_many :user_registration_forms

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates_presence_of :password
  validates_inclusion_of :admin, in: [true, false]

  scope :admin, -> { where(admin: true) }

  def admin?
    admin
  end
end