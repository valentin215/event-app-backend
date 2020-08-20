# frozen_string_literal: true

# This service help us to validate the creation of a user or not
# when an Admin set an attribute required on profile or on signup
class UserCustomAttributesValidator
  def initialize(params)
    @params = params
  end

  def on_create
    required_ids_on_create = CustomAttribute.required_for_signup.pluck(:id)
    validate_presence_of_attributes_id(required_ids_on_create)
  end

  def on_update
    required_ids_on_update = CustomAttribute.required_for_profile.pluck(:id)
    validate_presence_of_attributes_id(required_ids_on_update)
  end

  private

  def validate_presence_of_attributes_id(required_ids)
    params_ids = @params.dig(:user_custom_attributes).map { |key, value| key.to_s.to_i }
    params_ids.intersection(required_ids) == required_ids
  end
end