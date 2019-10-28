class CreateManagersProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :managers_projects do |t|
      t.integer :manager_id, null: false, index: true
      t.references :project, null: false, foreign_key: true
    end
    add_foreign_key :managers_projects, :users, column: :manager_id
  end
end