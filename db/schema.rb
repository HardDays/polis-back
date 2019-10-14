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

ActiveRecord::Schema.define(version: 2019_10_14_104710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "car_brands", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "car_models", force: :cascade do |t|
    t.string "title"
    t.integer "car_brand_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "car_types", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "car_usetypes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cars", force: :cascade do |t|
    t.integer "car_type_id"
    t.integer "car_brand_id"
    t.integer "car_model_id"
    t.integer "power"
    t.string "vin"
    t.integer "year"
    t.string "body_number"
    t.string "chassis_number"
    t.integer "wight"
    t.integer "max_wight"
    t.integer "seats"
    t.integer "document_type"
    t.string "document_serial"
    t.string "document_number"
    t.date "document_date"
    t.string "dc"
    t.date "dc_date"
    t.date "dc_issue_date"
    t.integer "owner_id"
    t.integer "car_usetype_id"
    t.integer "registered_abroad"
    t.integer "registration_way"
    t.integer "use_trailer"
    t.string "prev_policy_serial"
    t.string "prev_policy_number"
    t.integer "insurers_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string "lastname"
    t.string "firstname"
    t.string "middlename"
    t.date "birthdate"
    t.date "expdate"
    t.string "license_serial"
    t.string "license_number"
    t.date "license_date"
    t.integer "license_foreign"
    t.integer "car_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "insurance_companies", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "insurers", force: :cascade do |t|
    t.string "lastname"
    t.string "firstname"
    t.string "middlename"
    t.date "birthdate"
    t.string "passport_serial"
    t.string "passport_number"
    t.date "passport_date"
    t.integer "passport_foreign"
    t.string "name"
    t.string "inn"
    t.string "document_serial"
    t.string "document_number"
    t.integer "city_id"
    t.string "street"
    t.string "house"
    t.string "apartment"
    t.string "fullkladr"
    t.string "zip"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string "lastname"
    t.string "firstname"
    t.string "middlename"
    t.date "birthdate"
    t.string "passport_serial"
    t.string "passport_number"
    t.date "passport_date"
    t.integer "passport_foreign"
    t.string "name"
    t.string "inn"
    t.string "document_serial"
    t.string "document_number"
    t.integer "city_id"
    t.string "street"
    t.string "house"
    t.string "apartment"
    t.string "fullkladr"
    t.string "zip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
