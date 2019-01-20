class AddOwnedIdToDriver < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :owned_id, :integer
  end
end
