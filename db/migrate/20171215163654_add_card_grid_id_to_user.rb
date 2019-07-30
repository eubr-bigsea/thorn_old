class AddCardGridIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :card_grid, foreign_key: true
  end
end
