class CreateDrugs < ActiveRecord::Migration[5.2]
  def change
    create_table :drugs do |t|
      t.string          :name,        null: false
      t.string          :target_ailment,       null: false
      t.string          :side_effects,         array: true,   default: []
      t.references      :pharma_company
      t.timestamps
    end
  end
end
