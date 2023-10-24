# Generate fake accounts and users

require 'faker'
puts 'Creating Accounts and Users... '
1.upto(2000) do |i|
  account = Account.new(
    name: Faker::Company.name,
    city: Faker::Address.city,
    status: ['active', 'inactive'].sample
  )
  1.upto(4 + rand(20).to_i) do |j|
    user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      role: ['admin', 'manager', 'employee'].sample,
      account: account
    )
  end
end
puts "Created #{Account.count} Accounts and #{User.count} Users"

puts 'Creating Vehicle Makes and Models... '
Faker::Vehicle.fetch_all('vehicle.makes').each do |make|
  vm = VehicleMake.create(name: make)
  Faker::Vehicle.fetch_all("vehicle.models_by_make.#{make}").each do |model|
    vm.vehicle_models.create(name: model)
  end
end
puts "Created #{VehicleMake.count} Vehicle Makes and #{VehicleModel.count} Vehicle Models"