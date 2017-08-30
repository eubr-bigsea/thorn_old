# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User.create(first_name: 'Matheus', last_name: 'Gonçalves', email: 'souzagonc@gmail.com', password: '123456', id: 6)
basic_cards = [
  ["video", "basicTutorial", "5_sHXJC9ocA", ""],
  ["latest-workflows", "latestUpdatedWorkflows", "", ""],
  ["message","releaseNotes", "","releaseNotesMessage"],
  ["latest-jobs", "latestUpdatedJobs", "", ""],
]

basic_cards.each do |category, title, link, content|
  Card.create(category: category, title: title, link: link, content: content)
end
