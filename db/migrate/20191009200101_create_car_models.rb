class CreateCarModels < ActiveRecord::Migration[6.0]
  def change
    create_table :car_models do |t|
      t.string :title
      t.integer :brand

      t.timestamps
    end
  end
end
