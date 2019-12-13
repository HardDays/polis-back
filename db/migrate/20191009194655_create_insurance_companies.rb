class CreateInsuranceCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :insurance_companies do |t|
      t.string :title

      t.timestamps
    end
  end
end
