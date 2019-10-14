class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.string :lastname
      t.string :firstname
      t.string :middlename
      t.date :birthdate
      t.string :passport_serial
      t.string :passport_number
      t.date :passport_date
      t.integer :passport_foreign
      t.string :name
      t.string :inn
      t.string :document_serial
      t.string :document_number
      t.integer :city_id
      t.string :street
      t.string :house
      t.string :apartment
      t.string :fullkladr
      t.string :zip

      t.timestamps
    end
  end
end
