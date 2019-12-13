class CreateCarUsetypes < ActiveRecord::Migration[6.0]
  def change
    create_table :car_usetypes do |t|
      t.string :title

      t.timestamps
    end
  end
end
