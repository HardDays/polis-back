class AddForeignLicenseTypeToDriversTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :drivers, :license_foreign, :licenseForeign
  end
end
