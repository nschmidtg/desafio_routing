class AddCosts < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :daily_cost, :integer
    add_column :vehicles, :usage_cost_per_commune, :integer
    add_column :routes, :unsatisfied_cost, :integer
    add_column :routes, :storage_cost_per_load, :integer
  end
end
