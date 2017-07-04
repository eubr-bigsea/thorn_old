# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User.create(first_name: 'Matheus', last_name: 'Gonçalves', email: 'souzagonc@gmail.com', password: '123456', id: 6)
basic_cards = [
  ["message","Release notes", "","This is the version 2.0 of application Lemonade! With new operations, faster and simple to use this version brings the power of Apache Spark to execute data minning as easy as build a flow."],
  ["latest-workflows", "Latest updated workflows", "", ""],
  ["video", "Basic tutorial", "5_sHXJC9ocA", ""],
  ["latest-jobs", "Latest updated jobs", "", ""]
]

basic_cards.each do |category, title, link, content|
  Card.create(category: category, title: title, link: link, content: content)
end
