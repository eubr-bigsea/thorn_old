class CreateJoinTableCardUser < ActiveRecord::Migration[5.0]
  def change
    create_join_table :cards, :users do |t|
      t.index %i[card_id user_id]
      t.index %i[user_id card_id]
    end
  end
end
