# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def time_point_string; Time.now.strftime("%H:%M:%S:%L") end

def seedfile(fname)
  File.open File.join(Rails.root, "db/seeds_files/", fname)
end

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
puts "#{time_point_string}: seed Pages"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
Page.create!([
  { title: "About us", path: "about", prior: 1,
    body: "CheckMed is the good project" }
])


# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Settings"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
settings = Setting.create!([
  { ident: "outer_links",
    vtype: Setting::VTYPE_TEXT,
    often: true },
  { ident: "homepage_greeting_image",
    vtype: Setting::VTYPE_FILE },
  { ident: "homepage_greeting_text",
    vtype: Setting::VTYPE_TEXT,
    val: 'Medical checklists made easy. Create, share and&nbsp;use checklists for&nbsp;every condition' }
])
settings[1].value = seedfile "ill.png"
settings[1].save

# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Admin Users"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
AdminUser.create!(email: 'admin@example.com',
                  name: 'Master Admin',
                  password: 'password',
                  password_confirmation: 'password')


# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Users"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
def_user = User.new email: 'user@example.com',
                    password: 'password',
                    password_confirmation: 'password',
                    name: 'Default Doctor',
                    company: 'Main Hospital of USA',
                    academ_inst: "NAM",
                    position: 'MD'
def_user.skip_confirmation!
def_user.save

sec_user = User.new email: 'user2@example.com',
                    password: 'password',
                    password_confirmation: 'password',
                    name: 'Jason Born',
                    company: 'Angkor WAT UPFC',
                    academ_inst: "COD",
                    position: 'Intern'
sec_user.skip_confirmation!
sec_user.save


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
puts "#{time_point_string}: seed Specialities"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
specialities = Speciality.create!([
    { name: 'Immunology',   prior: 1 },
    { name: 'Cardiology',   prior: 2 },
    { name: 'Microbiology', prior: 3 },
    { name: 'Paediatrics',  prior: 4 }
  ])


# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Checklist Types"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
checklist_types = ChecklistType.create!([
    { name: 'Checklist', prior: 1 },
    { name: 'Protocol',  prior: 2 },
  ])

# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
puts "#{time_point_string}: seed Checklists and it's Items"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
def_user.checklists.create!({
    name: "The first Checklist",
    checklist_type: checklist_types[0],
    executor_role: executor_roles[3],
    speciality: specialities[0],
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

sec_user.checklists.create!({
    name: "Outpatient CHF",
    checklist_type: checklist_types[0],
    executor_role: executor_roles[1],
    speciality: specialities[2],
    treat_stage: 1
  })

puts "#{time_point_string}: Seeding is done!"
