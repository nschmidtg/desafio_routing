class ChangeFromVehicleLoadTypeEnum < ActiveRecord::Migration[5.2]
  def self.down
    remove_column :vehicles, :load_type
  end
end
