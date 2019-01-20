class RemoveFieldsCommunes < ActiveRecord::Migration[5.2]
  def change
    remove_column :communes, :nombre_provincia
    remove_column :communes, :nombre_region
    remove_column :communes, :nombre_pais
    remove_column :communes, :nombre_ciudad
  end
end
