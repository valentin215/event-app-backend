class CreateEventCustomAttributeValues < ActiveRecord::Migration[6.0]
  def change
    create_table :event_custom_attribute_values do |t|
      t.text :content, null: false
      t.references :event, null: false, foreign_key: true
      t.references :custom_attribute, null: false, foreign_key: true

      t.timestamps
    end
  end
end
