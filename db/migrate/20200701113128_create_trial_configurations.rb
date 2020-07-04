class CreateTrialConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :trial_configurations do |t|
      t.string        :name,    default: ""
      t.references    :drug
      t.references    :doctor
      t.references    :clinic
      t.timestamps
    end
  end
end
