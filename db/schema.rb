# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_19_121351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "custom_attributes", force: :cascade do |t|
    t.text "name", null: false
    t.boolean "for_user", default: false, null: false
    t.boolean "for_event_registration", default: false, null: false
    t.boolean "required_for_signup", default: false, null: false
    t.boolean "required_for_profile", default: false, null: false
    t.boolean "required_for_event", default: false, null: false
    t.string "attribute_type", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_custom_attributes_on_event_id"
  end

  create_table "event_custom_attribute_values", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "event_id", null: false
    t.bigint "custom_attribute_id", null: false
    t.bigint "event_registration_form_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["custom_attribute_id"], name: "index_event_custom_attribute_values_on_custom_attribute_id"
    t.index ["event_id"], name: "index_event_custom_attribute_values_on_event_id"
    t.index ["event_registration_form_id"], name: "index_event_attribute_values_on_event_form"
  end

  create_table "event_registration_forms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_event_registration_forms_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_custom_attribute_values", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.bigint "custom_attribute_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["custom_attribute_id"], name: "index_user_custom_attribute_values_on_custom_attribute_id"
    t.index ["user_id"], name: "index_user_custom_attribute_values_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "password", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "custom_attributes", "events"
  add_foreign_key "event_custom_attribute_values", "custom_attributes"
  add_foreign_key "event_custom_attribute_values", "event_registration_forms"
  add_foreign_key "event_custom_attribute_values", "events"
  add_foreign_key "user_custom_attribute_values", "custom_attributes"
  add_foreign_key "user_custom_attribute_values", "users"
end
