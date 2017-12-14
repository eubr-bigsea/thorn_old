class CardGrid < ApplicationRecord
  after_initialize :assign_defaults, if: 'new_record?'
  belongs_to :user
  serialize :configurations, Array

  private

  def assign_defaults
    self.configurations =  [
      {cardId: 1, component: "video", x: 0, y: 0, width: 6, height: 5, uuid: '42e188b2-3aa5-4b00-ba27-df8fa4a85e77' },
      {cardId: 2, component: "latest-workflows", x: 6, y: 0, width: 6, height: 5, uuid: 'ac37144f-04b1-4d62-9e40-ae91b7a97c40' },
      {cardId: 3, component: "latest-jobs", x: 6, y: 5, width: 6, height: 5, uuid: '6c8b0a21-f17c-43fd-a642-45f5b541efc5'},
      {cardId: 4, component: "message", x: 0, y: 5, width: 6, height: 5, uuid: 'adb75d63-c413-49a1-9f2a-f24f9c086daa'}
    ]
  end
end
