# frozen_string_literal: true

# Simple User class
class User < ApplicationRecord
  has_many :user_custom_attribute_values, dependent: :destroy
  has_many :event_registration_forms
  has_many :events, through: :event_registration_forms

  validates :name, uniqueness: true, presence: true, case_sensitive: false
  validates_presence_of :password
  validates_inclusion_of :admin, in: [true, false]

  scope :admin, -> { where(admin: true) }

  def admin?
    admin
  end
end