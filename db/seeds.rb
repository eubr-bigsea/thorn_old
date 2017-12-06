# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User.create(first_name: 'Matheus', last_name: 'Gonçalves', email: 'souzagonc@gmail.com', password: '123456', id: 6)
basic_cards = [
  { component: "video", title: "t('basicTutorial')", content: { link: '5_sHXJC9ocA'} },
  { component: "latest-workflows", title: "t('latestUpdatedWorkflows')", content: { count: 5} },
  { component: "latest-jobs", title: "t('latestUpdatedJobs')", content: { count: 5 } },
  { component: "message", title: "t('releaseNotes')", content: { message: 'releaseNotesMessage'} }
]

basic_cards.each do |card|
  Card.create(card)
end
