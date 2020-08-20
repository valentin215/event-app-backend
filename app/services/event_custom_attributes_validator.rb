# frozen_string_literal: true

# This service help us to validate the creation of a event or not
# when an Admin set an attribute required on the registration form
class EventCustomAttributesValidator
  def initialize(params)
    @params = params
  end

  def self.call(params)
    new(params).on_registration
  end

  def on_registration
    required_ids_on_form_registration = CustomAttribute.required_for_event_form.pluck(:id)
    validate_presence_of_attributes_id(required_ids_on_form_registration)
  end

  private

  def validate_presence_of_attributes_id(required_ids)
    params_ids = @params.dig(:event_custom_attributes).map { |key, value| key.to_s.to_i }
    params_ids.intersection(required_ids) == required_ids
  end
end
