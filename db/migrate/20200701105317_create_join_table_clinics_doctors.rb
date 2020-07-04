class CreateJoinTableClinicsDoctors < ActiveRecord::Migration[5.2]
  def change
    create_join_table :clinics, :doctors do |t|
      t.index [:clinic_id, :doctor_id]
      # t.index [:doctor_id, :clinic_id]
    end
  end
end
