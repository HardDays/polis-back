class ChangeOwnersColumCity < ActiveRecord::Migration[6.0]
  def change
    change_column :owners, :city, :string
  end
end
