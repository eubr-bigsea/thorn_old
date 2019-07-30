class CreateCardGrids < ActiveRecord::Migration[5.0]
  def change
    create_table :card_grids do |t|
      t.references :user, foreign_key: true
      t.text :configurations

      t.timestamps
    end
  end
end
