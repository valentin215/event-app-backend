class CreateCustomAttributes < ActiveRecord::Migration[6.0]
  def change
    create_table :custom_attributes do |t|
      t.text :name, null: false
      t.boolean :for_user, default: false, null: false
      t.boolean :for_event_registration, default: false, null: false
      t.boolean :required_for_signup, default: false, null: false
      t.boolean :required_for_profile, default: false, null: false
      t.boolean :required_for_event, default: false, null: false
      t.string :attribute_type, null: false
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
