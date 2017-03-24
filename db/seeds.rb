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
puts "#{time_point_string}: seed Admin Users"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
AdminUser.create!(email: 'admin@example.com',
                  password: 'password',
                  password_confirmation: 'password')


# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Users"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
def_user = User.create! email: 'user@example.com',
                        password: 'password',
                        password_confirmation: 'password',
                        name: 'Default Doctor',
                        company: 'Main Hospital of USA',
                        position: 'MD'


# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Executor Roles"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
executor_roles = ExecutorRole.create!([
    { name: 'Medical Students', prior: 1 },
    { name: 'Interns',          prior: 2 },
    { name: 'Nursing staff',    prior: 3 },
    { name: 'Pharmacists',      prior: 4 }
  ])


# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Checklists and it's Items"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
def_user.checklists.create!({
    name: "The first Checklist",
    executor_role: executor_roles[3],
    treat_stage: 1,
    descr: "This is the first created checklist of the first created user.",
    groups_attributes: [
      {
        name: 'Symptoms questions',
        prior: 0,
        items_attributes: [
          { title: "Has runny or stuffy nose?", prior: 0 },
          { title: "Has cough?",                prior: 1 }
        ]
      },
      {
        name: 'Labs questions',
        prior: 1,
        items_attributes: [
          { title: "Hemoglobin level", prior: 0, answers_attributes: [
              { val: "Low",   tip: "It's bad",     prior: 0 },
              { val: "Hight", tip: "It's bad too", prior: 1 },
              { val: "Other", commentable: true,   prior: 2 }
            ]
          }
        ]
      }
    ]
  })

puts "#{time_point_string}: Seeding is done!"
