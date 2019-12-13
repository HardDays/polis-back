class RenameFeldCityIdToOwners < ActiveRecord::Migration[6.0]
  def change
    rename_column :owners, :city_id, :city
  end
end
