class CreateEventRegistrationForms < ActiveRecord::Migration[6.0]
  def change
    create_table :event_registration_forms do |t|
      t.references :user, null: false
      t.references :event, null: false

      t.timestamps
    end
  end
end
