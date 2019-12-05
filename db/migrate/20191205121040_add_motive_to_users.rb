class AddMotiveToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :motive, :string
  end
end
