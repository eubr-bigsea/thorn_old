class CreateMonitorsTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :monitors_teams do |t|
      t.integer :monitor_id, null: false, index: true
      t.references :team, null: false, foreign_key: true
    end
    add_foreign_key :monitors_teams, :users, column: :monitor_id
  end
end
