class RemoveRegionIdFromCommunes < ActiveRecord::Migration[5.2]
  def change
    remove_column :communes, :region_id
    drop_table :regions
  end
end
