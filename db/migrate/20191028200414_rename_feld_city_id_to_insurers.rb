class RenameFeldCityIdToInsurers < ActiveRecord::Migration[6.0]
  def change
    rename_column :insurers, :city_id, :city
  end
end
