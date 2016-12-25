# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
account = Account.create(name: 'Seed Account One', subdomain: 'seed-account-01',
                         users_attributes: [{
                                                email: 'demo_01@seed-account.com',
                                                password: 'Welcome@123',
                                                password_confirmation: 'Welcome@123'
                                            }])

App::ENVIRONMENTS.each do |environment|
  account.apps.create(name: 'App One', environment: environment)
end