# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

login = "macbury"
password ="root"
email = "macbury@gmail.com"

user = User.new( :login => login, :password => password, :password_confirmation => password, :email => email )
user.admin = true
user.save