class AddRememberToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :remember, :boolean, default: false
  end
end
