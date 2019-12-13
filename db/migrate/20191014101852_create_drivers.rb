class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.string :lastname
      t.string :firstname
      t.string :middlename
      t.date :birthdate
      t.date :expdate
      t.string :license_serial
      t.string :license_number
      t.date :license_date
      t.integer :license_foreign
      t.integer :car_id

      t.timestamps
    end
  end
end
