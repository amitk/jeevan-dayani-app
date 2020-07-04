class CreateTrials < ActiveRecord::Migration[5.2]
  def change
    create_table :trials do |t|
      t.string        :name
      t.integer       :phase,   default: 1
      t.string        :status,  default: "active"
      t.references  :trial_configuration
      t.timestamps
    end
  end
end
