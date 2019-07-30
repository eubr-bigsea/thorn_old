class RemoveTables < ActiveRecord::Migration[6.0]
  def up
    remove_foreign_key :card_grids, :users
    remove_foreign_key :users, :card_grids
    remove_index :users, :card_grid_id
    drop_table :cards
    drop_table :card_grids

    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in_ip
    remove_column :users, :profile_picture
    remove_column :users, :authentication_token
    remove_column :users, :card_grid_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
