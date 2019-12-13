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

ActiveRecord::Schema.define(version: 2019_11_30_134854) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agreements", force: :cascade do |t|
    t.string "access_id"
    t.string "access_code"
    t.integer "car_id"
    t.integer "multidrive"
    t.integer "owner_id"
    t.integer "insurerIsOwner"
    t.integer "insurer_id"
    t.string "purpose", default: "personal"
    t.integer "registeredAbroad", default: 0
    t.integer "registrationWay", default: 0
    t.integer "useTrailer", default: 0
    t.integer "violations", default: 0
    t.date "date"
    t.integer "usePeriod", default: 12
    t.string "name"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "licensePlate"
  end

  create_table "agreements_tables", force: :cascade do |t|
  end

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
    t.string "label"
  end

  create_table "car_usetypes", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cars", force: :cascade do |t|
    t.integer "type", default: 1, null: false
    t.integer "power", null: false
    t.integer "year", null: false
    t.string "vin"
    t.string "bodyNum"
    t.string "chassisNum"
    t.integer "docType", default: 1, null: false
    t.string "docSerial"
    t.string "docNumber"
    t.datetime "docDate"
    t.string "brand", null: false
    t.string "model", null: false
    t.string "dc"
    t.datetime "dcDate"
    t.datetime "dcIssueDate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string "lastname"
    t.string "firstname"
    t.string "middlename"
    t.date "birthdate"
    t.date "expdate"
    t.string "licenseSerial"
    t.string "licenseNumber"
    t.date "licenseDate"
    t.integer "licenseForeign"
    t.integer "agreement_id", null: false
    t.string "prevLicenseSerial"
    t.string "prevLicenseNumber"
    t.date "prevLicenseDate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "exp"
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
    t.string "passportSerial"
    t.string "passportNumber"
    t.date "passportDate"
    t.integer "passportForeign", default: 0
    t.string "city"
    t.string "street"
    t.string "house"
    t.string "apartment"
    t.string "fullkladr"
    t.string "zip"
    t.string "fullAddress"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string "lastname"
    t.string "firstname"
    t.string "middlename"
    t.date "birthdate"
    t.string "passportSerial"
    t.string "passportNumber"
    t.date "passportDate"
    t.integer "passportForeign", default: 0
    t.string "city"
    t.string "street"
    t.string "house"
    t.string "apartment"
    t.string "fullkladr"
    t.string "zip"
    t.string "fullAddress"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
