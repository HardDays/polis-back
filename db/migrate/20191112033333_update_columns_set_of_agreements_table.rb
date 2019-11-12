class UpdateColumnsSetOfAgreementsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :agreements, :licensePlate, :string
    rename_column :agreements, :insurer, :insurer_id
  end
end
