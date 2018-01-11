class DropCardsTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :cards
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
