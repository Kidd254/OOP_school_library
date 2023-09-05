require 'json'
require 'date'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'associations/book'
require_relative 'user_interaction'
require_relative 'associations/rental'

class App
  def initialize
    @books = []
    @people = []
    @rental = []
  end

  def list_books
    @books.each_with_index do |book, index|
      puts "Index: #{index}, Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    @people.each do |person|
      role = person.is_a?(Student) ? 'Student' : 'Teacher'
      puts "#{role}: #{person.name} #{person.id}"
    end
  end

  def create_person
    user_int = Userinteraction.new

    role = user_int.create_role
    if role != 'student' && role != 'teacher'
      puts 'Invalid role'
      return
    end

    classroom = user_int.classroom_value if role == 'student'

    name = user_int.obtain_person_name

    age = user_int.obtain_person_age

    if role == 'student'
      pp = user_int.parent_permission_value
      person = Student.new(age, classroom, name, parent_permission: pp)
    end

    if role == 'teacher'
      spec = user_int.specialization_value
      person = Teacher.new(age, name, specialization: spec)
    end

    @people << person
    puts "#{role.capitalize} '#{name}' created."
  end

  def create_book_prompt
    user_int = Userinteraction.new

    title = user_int.enter_book_title
    author = user_int.enter_book_author

    book = Book.new(title, author)
    @books << book

    puts "Book '#{title}' by #{author} created."
  end

  def create_rental_prompt
    user_int = Userinteraction.new

    list_people
    person_id = user_int.enter_person_id

    list_books
    book_id = user_int.enter_book_id

    create_rental(person_id, book_id)
  end

  def create_rental(person_id, book_id)
    person = @people.find { |p| p.id == person_id }

    if person.nil?
      puts 'Person not found.'
      return
    end

    book = @books[book_id]

    if book.nil?
      puts 'Book not found.'
      return
    end

    @rental << Rental.new(Date.today, book, person)

    puts "Rental created for '#{person.name}' and '#{book.title}' on #{Date.today}."
  end

  def list_rentals_for_person_prompt
    user_int = Userinteraction.new
    list_rentals_for_person(user_int.enter_person_id)
  end

  def list_rentals_for_person(person_id)
    @rental.each do |rt|
      puts "date: #{rt.date}, title: #{rt.book.title}, person: #{rt.person.name}" if rt.person.id == person_id
    end
  end

  def save_data
    save_books
    save_people
    save_rentals
  end

  # Load all data from JSON files
  def load_data
    load_books
    load_people
    load_rentals
  end

  private

  def save_books
    book_data = @books.map(&:to_hash)
    File.write('books.json', JSON.generate(book_data))
  end

  def load_books
    if File.exist?('books.json')
      file_data = File.read('books.json')
      book_data = JSON.parse(file_data)
      @books = book_data.map { |data| Book.from_hash(data) }
    else
      @books = [] # Initialize as an empty array if the file doesn't exist
    end
  end  

  def save_people
    people_data = @people.map(&:to_hash)
    File.write('people.json', JSON.generate(people_data))
  end

  def load_people
    if File.exist?('people.json')
      file_data = File.read('people.json')
      people_data = JSON.parse(file_data)
      @people = people_data.map do |person_data|
        if person_data && person_data['role']
          if person_data['role'] == 'student'
            Student.from_hash(person_data)
          elsif person_data['role'] == 'teacher'
            Teacher.from_hash(person_data)
          else
            puts "Invalid role: #{person_data['role']}"
            nil # Return nil for invalid data
          end
        else
          puts "Invalid or missing data in JSON: #{person_data}"
          nil # Return nil for invalid data
        end
      end.compact # Remove any nil entries
    else
      @people = []
    end
  end
  

  def save_rentals
    rental_data = @rental.map(&:to_hash)
    File.write('rentals.json', JSON.generate(rental_data))
  end  

  def load_rentals
    if File.exist?('rentals.json')
      file_data = File.read('rentals.json')
      rentals_data = JSON.parse(file_data)
      @rental = rentals_data.map do |rental_data|
        if rental_data && rental_data['date'] && rental_data['book'] && rental_data['person']
          book = Book.from_hash(rental_data['book'])
          person = Person.from_hash(rental_data['person'])
          Rental.new(Date.parse(rental_data['date']), book, person)
        else
          puts "Invalid or missing data in JSON: #{rental_data}"
        end
      end
    else
      @rental = []
    end
  end
end
