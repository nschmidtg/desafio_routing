class AddColumnsToRoutes < ActiveRecord::Migration[5.2]
  def self.up
    add_column :routes, :load_type_id, :integer
    remove_column :routes, :load_type
  end
end
