class RenameFieldnameToOwners < ActiveRecord::Migration[6.0]
  def change
    rename_column :owners, :passport_serial, :passportSerial
    rename_column :owners, :passport_number, :passportNumber
  end
end
