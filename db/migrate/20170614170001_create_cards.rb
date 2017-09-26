class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :category
      t.string :title
      t.string :link
      t.string :content
      t.timestamps
    end
  end
end
