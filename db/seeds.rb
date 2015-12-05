# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Creating users..."
user = User.create(name:"abc", email:"a@bc.com", password:"abc")
user.save

puts "Creating facts...current DIR=#{Dir.pwd}/db/facts.txt"
File.open("#{Dir.pwd}/db/facts.txt", "r").first(10).each do |line|
  Fact.create!(content:line, user_id:user.id)
end
