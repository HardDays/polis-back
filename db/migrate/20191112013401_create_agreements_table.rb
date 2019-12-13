class CreateAgreementsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :agreements_tables do |t|
      create_table "agreements", force: :cascade do |t|
        t.string :access_id
        t.string :access_code
        t.integer :car_id
        t.integer :multidrive
        t.integer :owner_id
        t.integer :insurerIsOwner
        t.integer :insurer
        t.string :purpose, default: 'personal'
        t.integer :registeredAbroad, default: 0
        t.integer :registrationWay, default: 0
        t.integer :useTrailer, default: 0
        t.integer :violations, default: 0
        t.date :date
        t.integer :usePeriod, default: 12
        t.string :name
        t.string :phone
        t.string :email
        t.datetime "created_at", precision: 6, null: false
        t.datetime "updated_at", precision: 6, null: false
      end
    end
  end
end
