class CreateTeamsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :teams_users do |t|
    end
    add_reference :teams_users, :team, null: false, foreign_key: true, type: :bigint
    add_reference :teams_users, :user, null: false, foreign_key: true, type: :integer
  end
end
