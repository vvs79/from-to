# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(login: 'admin', first_name: 'Admin', last_name: 'Admin', email: 'a@a.com', password: '87654321', admin: true)
User.create!(login: 'user', first_name: 'User', last_name: 'User', email: 'u@u.com', password: '12345678', admin: false)

25.times do |i|
  login = 'login_' + i.to_s
  first_name = 'fname_' + i.to_s
  last_name = 'lname_' + i.to_s
  email = "user" + i.to_s + "@u.com"
  User.create!(login: login, first_name: first_name, last_name: last_name, email: email, password: '12345678', admin: false)
end

Line.create!(line: 'AB', kilometers: 80, minutes: 40)
Line.create!(line: 'AC', kilometers: 110, minutes: 55)
Line.create!(line: 'AE', kilometers: 330, minutes: 240)
Line.create!(line: 'BF', kilometers: 340, minutes: 230)
Line.create!(line: 'CD', kilometers: 60, minutes: 20)
Line.create!(line: 'CE', kilometers: 205, minutes: 80)
Line.create!(line: 'DF', kilometers: 192, minutes: 110)
Line.create!(line: 'EF', kilometers: 80, minutes: 40)
