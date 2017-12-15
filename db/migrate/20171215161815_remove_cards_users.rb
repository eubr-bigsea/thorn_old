class RemoveCardsUsers < ActiveRecord::Migration[5.0]
  def up
    drop_table :cards_users
  end
end
