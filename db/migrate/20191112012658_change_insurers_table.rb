class ChangeInsurersTable < ActiveRecord::Migration[6.0]
  def change
    create_table "insurers", force: :cascade do |t|
      t.string :lastname
      t.string :firstname
      t.string :middlename, null: true
      t.date :birthdate
      t.string :passportSerial
      t.string :passportNumber
      t.date :passportDate
      t.integer :passportForeign, default: 0
      t.string :city
      t.string :street
      t.string :house
      t.string :apartment
      t.string :fullkladr
      t.string :zip
      t.string :fullAddress
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
    end
  end
end
