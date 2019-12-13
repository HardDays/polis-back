class AddExpToDrivers < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :exp, :integer
  end
end
