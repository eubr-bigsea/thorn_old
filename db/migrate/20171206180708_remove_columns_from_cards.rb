class RemoveColumnsFromCards < ActiveRecord::Migration[5.0]
  def change
    remove_column :cards, :link, :string
    remove_column :cards, :category, :string
  end
end
