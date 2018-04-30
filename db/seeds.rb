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

 chat_rooms = [
 	{name: 'Sport'},
 	{name: 'Politics'},
 	{name: 'Travel'},
 	{name: 'Technology'},
 	{name: 'Food'}
 ]

ChatRoom.create!(chat_rooms)

User.all.each do |user| 
	x = ChatRoom.all.shuffle 
	random_chat = [x[0],x[1]]
	user.chat_rooms << random_chat 
end 

messages = [
	['blah'],
	['hi'],
	['array'],
	['foo'],
	['bar'],
	['blah'],
	['hi'],
	['array'],
	['foo'],
	['bar']	
]

User.all.each do |user| 
	user.chat_rooms.each do |cr| 
		m = messages.shuffle
		Message.create!(content: m[0], user: user, chat_room: cr)
	end 
end 







