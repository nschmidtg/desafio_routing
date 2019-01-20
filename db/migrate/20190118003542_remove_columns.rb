class RemoveColumns < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :vehicles, :load_type
  end
end
