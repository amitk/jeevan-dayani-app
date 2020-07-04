class CreatePharmaCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :pharma_companies do |t|
      t.string :name,      null: false
      t.timestamps
    end
  end
end
