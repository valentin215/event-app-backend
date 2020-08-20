# frozen_string_literal: true

# Simple Event class
class Event < ApplicationRecord
  has_many :event_registration_forms, dependent: :destroy
  has_many :users, through: :event_registration_forms
  has_many :custom_attributes, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false }, presence: true
end
