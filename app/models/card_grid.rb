class CardGrid < ApplicationRecord
  after_initialize :assign_defaults, if: 'new_record?'
  belongs_to :user
  serialize :configurations, Array

  private

  def assign_defaults
    self.configurations =  [
      {cardId: 1, component: "video", x: 0, y: 0, width: 6, height: 5 },
      {cardId: 2, component: "latest-workflows", x: 6, y: 0, width: 6, height: 5 },
      {cardId: 3, component: "latest-jobs", x: 6, y: 5, width: 6, height: 5},
      {cardId: 4, component: "message", x: 0, y: 5, width: 6, height: 5}
    ]
  end
end
