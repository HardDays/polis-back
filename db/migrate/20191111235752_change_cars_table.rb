class ChangeCarsTable < ActiveRecord::Migration[6.0]
  def change
    # delete_table :cars
    create_table :cars, force: :cascade do |t|
      t.integer :type, default: 1, null: false
      t.integer :power, null: false
      t.integer :year, null: false
      t.string :vin, null:true
      t.string :bodyNum, null: true
      t.string :chassisNum, null: true
      t.integer :docType, default: 1, null: false
      t.string :docSerial, null: true
      t.string :docNumber, null: true
      t.datetime :docDate, null: true
      t.string :brand, null: false
      t.string :model, null: false
      t.string :dc, null: true
      t.datetime :dcDate, null: true
      t.datetime :dcIssueDate, null: true
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
    end
  end
end
