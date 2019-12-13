class AddNumberPlateToCars < ActiveRecord::Migration[6.0]
  def change
    add_column :cars, :number_plate, :string
  end
end
