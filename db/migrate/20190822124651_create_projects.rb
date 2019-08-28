class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :category
      t.string :subcategory
      t.string :description

      t.timestamps
    end
    add_index :projects, :name, unique: true
  end
end
