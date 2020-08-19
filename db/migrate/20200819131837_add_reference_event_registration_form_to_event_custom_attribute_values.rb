class AddReferenceEventRegistrationFormToEventCustomAttributeValues < ActiveRecord::Migration[6.0]
  def change
    add_reference :event_custom_attribute_values, :event_registration_form,
                  null: false,
                  foreign_key: true,
                  index: { name: 'index_event_attribute_values_on_event_form' }
  end
end
