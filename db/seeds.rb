# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin_user = User.create(email: "wizard.resonant@gmail.com", password: "cricket79")
roger_user = User.create(email: "rogerzavarce@gmail.com", password: "raza14532")
admin_role = Role.create(name: "Administrator")
supplier_role = Role.create(name: "Supplier")
customer_role = Role.create(name: "Customer")
agent_role = Role.create(name: "Agent")
Assignment.create(role: admin_role, user: admin_user)
Assignment.create(role: admin_role, user: roger_user)