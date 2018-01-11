class AddComponentToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :component, :string
    change_column :cards, :content, :text
  end
end
