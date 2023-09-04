require 'pry'
require_relative 'app'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'associations/book'

app = App.new

loop do
  puts 'Choose an option:'
  puts '1. List all books'
  puts '2. List all people'
  puts '3. Create a person'
  puts '4. Create a book'
  puts '5. Create a rental'
  puts '6. List all rentals for a person'
  puts '7. Quit'

  choice = gets.chomp.to_i

  case choice
  when 1
    app.list_books
  when 2
    app.list_people
  when 3
    app.create_person_prompt
  when 4
    app.create_book_prompt
  when 5
    app.create_rental_prompt
  when 6
    app.list_rentals_for_person_prompt
  when 7
    puts 'Goodbye!'
    break
  else
    puts 'Invalid option. Please choose again.'
  end
end
