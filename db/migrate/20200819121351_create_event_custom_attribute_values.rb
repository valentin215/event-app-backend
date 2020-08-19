class CreateEventCustomAttributeValues < ActiveRecord::Migration[6.0]
  def change
    create_table :event_custom_attribute_values do |t|
      t.text :content, null: false
      t.references :event, null: false, foreign_key: true
      t.references :custom_attribute, null: false, foreign_key: true
      t.references :event_registration_form, null: false,
                                             foreign_key: true,
                                             index: { name: 'index_event_attribute_values_on_event_form' }

      t.timestamps
    end
  end
end
