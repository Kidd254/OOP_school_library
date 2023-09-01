require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'associations/book'
require_relative 'app'

app = App.new
# rubocop:disable Metrics/BlockLength
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
    puts 'Enter role (student/teacher):'
    role = gets.chomp.downcase
    app.create_person(role)
  when 4
    app.create_book
    app.instance_variable_get(:@books) # Print books array
  when 5
    puts 'Enter person ID:'
    person_id = gets.chomp.to_i
    person = app.instance_variable_get(:@people).find { |p| p.id == person_id }

    if person.nil?
      puts 'Person not found.'
      next
    end
    puts 'Enter book ID:'
    book_id = gets.chomp.to_i
    book = app.instance_variable_get(:@books).find { |b| b.id == book_id }

    if book.nil?
      puts 'Book not found.'
      next
    end
    app.create_rental(person_id, book_id)
  when 6
    puts 'Enter person ID:'
    person_id = gets.chomp.to_i
    app.list_rentals_for_person(person_id)
  when 7
    puts 'Goodbye!'
    break
  else
    puts 'Invalid option. Please choose again.'
  end
end
# rubocop:enable Metrics/BlockLength
