class CardGrid < ApplicationRecord
  after_initialize :assign_defaults, if: 'new_record?'
  belongs_to :user
  serialize :configurations, Array

  private

  def assign_defaults
    conf = []
    col = 2
    row = 0

    Card.all.each_with_index do |card, i|
      conf << { cardId: card.id, component: card.component, x: i%col*6, y: row*5,  width: 6, height: 5, uuid: SecureRandom.uuid }
      row = row + i%col
    end

    self.configurations = conf

  end
end
