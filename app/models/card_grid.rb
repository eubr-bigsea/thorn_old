class CardGrid < ApplicationRecord
  after_initialize :assign_defaults, if: 'new_record?'
  belongs_to :user
  serialize :configurations, Array

  private

  def assign_defaults

    cards = Card.all.to_a
    conf = []
    col = 2
    row = 0

    for i in 0..(Card.count-1)
      conf << { cardId: cards[i].id, component: cards[i].component, x: i%col*6, y: row*5,  width: 6, height: 5, uuid: SecureRandom.uuid }
      row = row + i%col
    end

    self.configurations = conf

  end
end
