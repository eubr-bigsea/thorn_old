class CreateCardBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :card_boards do |t|
      t.references :user, foreign_key: true
      t.text :board
      t.timestamps
    end
  end
end
