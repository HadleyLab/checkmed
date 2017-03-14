# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def time_point_string; Time.now.strftime("%H:%M:%S:%L") end

# def seedfile(fname)
#   File.open File.join(Rails.root, "public/content/seeds/", fname)
# end

# Use code of file 'db/seeds_contents.rb'. This is the way to split big
# seeds.rb file. You can use instance variables (@var) declared in that file.
# require_relative 'seeds_contents'

puts "#{time_point_string}: Start seeding"

# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
# puts "#{time_point_string}: seed Static Files"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --

# sig = StaticFile.new
# sig.file = seedfile "example_pic.jpg"
# sig.save


# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Users"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
User.create! email: 'user@example.com',
             password: 'password',
             password_confirmation: 'password',
             name: 'Default Doctor',
             company: 'Main Hospital of USA',
             position: 'MD'


# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Executor Roles"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
ExecutorRole.create!([
    { name: 'Medical Students', prior: 1 },
    { name: 'Interns',          prior: 2 },
    { name: 'Nursing staff',    prior: 3 },
    { name: 'Pharmacists',      prior: 4 }
  ])

puts "#{time_point_string}: Seeding is done!"
