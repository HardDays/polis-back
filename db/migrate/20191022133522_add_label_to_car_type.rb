class AddLabelToCarType < ActiveRecord::Migration[6.0]
  def change
      add_column :car_types, :label, :string
  end
end
