class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.references :user, foreign_key: true
      t.integer :tipo
      t.string :title
      t.string :link
      t.string :content
      t.timestamps
    end
  end
end
