class AddOwnerIdToVehicle < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :owner_id, :integer
  end
end
