class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string      :state,   null: false
      t.references  :patient
      t.references  :trial
      t.timestamps
    end
  end
end
