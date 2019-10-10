class RenameBrandInCarModels < ActiveRecord::Migration[6.0]
  def change
    rename_column :car_models, :brand, :car_brand_id
  end
end
