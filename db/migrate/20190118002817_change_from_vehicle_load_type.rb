class ChangeFromVehicleLoadType < ActiveRecord::Migration[5.2]
  def self.up
    add_column :vehicles, :load_type_id, :integer
  end
end
