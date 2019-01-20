class AddDriverIdToVehicle < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :driver_id, :integer
  end
end
