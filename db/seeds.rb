# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
if SearchItem.count > 0
  puts 'Skipping data ingestion because data already exists'
  return
end
puts 'Started data ingestion'
ImportData.new.json
puts 'Finished data ignestion'
