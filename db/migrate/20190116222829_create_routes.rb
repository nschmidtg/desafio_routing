class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :load_type
      t.float :load_sum
      t.integer :stops_ammount
      t.integer :vehicle_id
      t.integer :driver_id

      t.timestamps
    end
  end
end
