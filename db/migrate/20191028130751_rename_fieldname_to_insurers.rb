class RenameFieldnameToInsurers < ActiveRecord::Migration[6.0]
  def change
    rename_column :insurers, :passport_serial, :passportSerial
    rename_column :insurers, :passport_number, :passportNumber
  end
end
