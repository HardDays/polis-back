class ChangeDriversTable < ActiveRecord::Migration[6.0]
  def change
    create_table "drivers", force: :cascade do |t|
      t.string :lastname
      t.string :firstname
      t.string :middlename, null: true
      t.date :birthdate
      t.date :expdate
      t.string :licenseSerial
      t.string :licenseNumber
      t.date :licenseDate
      t.integer :license_foreign
      t.integer :agreement_id, null: false
      t.string :prevLicenseSerial, null: true
      t.string :prevLicenseNumber, null: true
      t.date :prevLicenseDate, null: true
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
    end
  end
end
