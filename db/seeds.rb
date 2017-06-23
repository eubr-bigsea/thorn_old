# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User.create(first_name: 'Matheus', last_name: 'Gonçalves', email: 'souzagonc@gmail.com', password: '123456', id: 6)
Card.create({tipo: 1, title: "Release notes", link: "", content: "This is the version 2.0 of application Lemonade! With new operations, faster and simple to use this version brings the power of Apache Spark to execute data minning as easy as build a flow."})
Card.create({tipo: 2, title: "Latest updated workflows", link: "", content: ""})
Card.create({tipo: 0, title: "Basic tutorial", link: "5_sHXJC9ocA", content: ""})
Card.create({tipo: 3, title: "Latest updated jobs", link: "", content: ""})
