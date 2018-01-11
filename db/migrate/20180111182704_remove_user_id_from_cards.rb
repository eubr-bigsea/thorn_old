class RemoveUserIdFromCards < ActiveRecord::Migration[5.0]
  def change
    remove_index :cards, column: :user_id
    remove_column :cards, :user_id, :int
  end
end
