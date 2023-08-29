require 'date'
require_relative 'rental'
require_relative 'book'
require_relative '../person'

book = Book.new('The Great Gatsby', 'F. Scott Fitzgerald')
person5 = Person.new('John Kidd', 26)
rental = Rental.new(Date.new(2023, 8, 1), book, person5)

puts "Rental Date: #{rental.date}"
puts "Rented Book Title: #{book.title}"
puts "Rented by Person: #{person5.name}"
