class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.integer :car_type_id
      t.integer :car_brand_id
      t.integer :car_model_id
      t.integer :power
      t.string :vin
      t.integer :year
      t.string :body_number
      t.string :chassis_number
      t.integer :wight
      t.integer :max_wight
      t.integer :seats
      t.integer :document_type
      t.string :document_serial
      t.string :document_number
      t.date :document_date
      t.string :dc
      t.date :dc_date
      t.date :dc_issue_date
      t.integer :owner_id
      t.integer :car_usetype_id
      t.integer :registered_abroad
      t.integer :registration_way
      t.integer :use_trailer
      t.string :prev_policy_serial
      t.string :prev_policy_number
      t.integer :insurers_id

      t.timestamps
    end
  end
end
