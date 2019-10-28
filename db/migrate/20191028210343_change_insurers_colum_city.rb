class ChangeInsurersColumCity < ActiveRecord::Migration[6.0]
  def change
    change_column :insurers, :city, :string
  end
end
