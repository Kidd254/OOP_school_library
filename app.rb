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
    File.write('people.json', JSON.generate(@people))
  end

  def load_people
    if File.exist?('people.json')
      file_data = File.read('people.json')
      @people = JSON.parse(file_data).map do |person_data|
        if person_data['role'] == 'student'
          Student.new(person_data['age'], person_data['classroom'], person_data['name'],
                      parent_permission: person_data['parent_permission'])
        elsif person_data['role'] == 'teacher'
          Teacher.new(person_data['age'], person_data['name'], specialization: person_data['specialization'])
        else

          puts "Invalid role: #{person_data['role']}"

        end
      end
    else
      @people = []
    end
  end

  def save_rentals
    File.write('rentals.json', JSON.generate(@rental))
  end

  def load_rentals
    if File.exist?('rentals.json')
      file_data = File.read('rentals.json')
      @rental = JSON.parse(file_data)
    else
      @rental = [] # Initialize as an empty array if the file doesn't exist
    end
  end
end
