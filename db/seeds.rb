# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User.create(first_name: 'Matheus', last_name: 'Gonçalves', email: 'souzagonc@gmail.com', password: '123456', id: 6)
# grid example
# grid = [
#  {cardId: 1, component: "video", x: 0, y: 0, width: 6, height: 5 },
#  {cardId: 2, component: "latest-workflows", x: 6, y: 0, width: 6, height: 5 },
#  {cardId: 3, component: "latest-jobs", x: 6, y: 5, width: 6, height: 5},
#  {cardId: 4, component: "message", x: 0, y: 5, width: 6, height: 5}
#]

basic_cards = [
  { component: "video", title: "t('basicTutorial')", content: { link: '5_sHXJC9ocA'} },
  { component: "latest-workflows", title: "t('latestUpdatedWorkflows')", content: { size: 5} },
  { component: "latest-jobs", title: "t('latestUpdatedJobs')", content: { size: 5 } },
  { component: "message", title: "t('releaseNotes')", content: { message: "t('releaseNotesMessage')"} }
]

basic_cards.each do |card|
  Card.create(card)
end
