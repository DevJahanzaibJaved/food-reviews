# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create an admin user for testing
admin = User.find_or_create_by!(email_address: "admin@foodreviews.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = "admin"
end

puts "Admin user created: #{admin.email_address}" if admin.persisted?

# Create a test restaurant owner user
restaurant_owner = User.find_or_create_by!(email_address: "restaurant@example.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = "restaurant_owner"
end

puts "Restaurant owner user created: #{restaurant_owner.email_address}" if restaurant_owner.persisted?

puts "\n=== Seed Data Created ==="
puts "Admin: admin@foodreviews.com / password123"
puts "Restaurant Owner: restaurant@example.com / password123"
