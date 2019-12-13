class RenameDriversFields < ActiveRecord::Migration[6.0]
  def change
    rename_column :drivers, :license_serial, :licenseSerial
    rename_column :drivers, :license_date, :licenseDate
    rename_column :drivers, :license_number, :licenseNumber
  end
end
