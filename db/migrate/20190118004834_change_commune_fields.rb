class ChangeCommuneFields < ActiveRecord::Migration[5.2]
  def self.up
    add_column :communes, :codigo, :integer
    add_column :communes, :nombre_comuna, :string
    add_column :communes, :nombre_provincia, :string
    add_column :communes, :nombre_region, :string
    add_column :communes, :nombre_pais, :string
    add_column :communes, :nombre_ciudad, :string
    
    remove_column :communes, :name
  end
end
