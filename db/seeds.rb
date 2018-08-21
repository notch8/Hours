# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create a new account object
# switch tenants
# Create a new user object for that account
# confirm that user
if Account.where(subdomain: 'testinstance').count < 1
    @signup = Signup.new(first_name: "Test", last_name: 'Tester', email: 'test@example.com', password: 'testing123', password_confirmation: 'testing123', subdomain: 'testinstance')
    if @signup.valid?
      Apartment::Tenant.create(@signup.subdomain)
      Apartment::Tenant.switch(@signup.subdomain)
      @signup.save
    end

    u = User.where(email: 'test@example.com').first
    u.confirm!
end
