class CreateCustomAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_attributes do |t|
      t.string :name
      t.boolean :for_user
      t.boolean :for_event_registration
      t.boolean :required_for_signup
      t.boolean :required_for_profile
      t.string :attribute_type
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
