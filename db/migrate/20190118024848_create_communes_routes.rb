class CreateCommunesRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :communes_routes do |t|
      t.integer :commune_id
      t.integer :route_id
    end
  end
end
