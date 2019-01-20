class CreateCommunesDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :communes_drivers do |t|
      t.integer :commune_id
      t.integer :driver_id

      t.timestamps
    end
  end
end
