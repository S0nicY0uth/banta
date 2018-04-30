# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



users = [
 	{name: 'Chris Hopkins', email: 'chris@hopkins.com', password: 'pass123'},
 	{name: 'Amy Allen', email: 'amy@allen.com', password: 'pass123'},
 	{name: 'Dan Stein', email: 'dan@stein.com', password: 'pass123'},
 	{name: 'Izzy Oakley', email: 'izzy@oakley.com', password: 'pass123'},
 	{name: 'Ben Pirt', email: 'ben@pirt.com', password: 'pass123'}

 ]

 User.create!(users)