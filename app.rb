require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'associations/book'

class App
  def initialize
    @books = []
    @people = []
    @rental = []
  end

  def list_books
    @books.each { |book| puts book.title }
  end

  def list_people
    @people.each do |person|
      role = person.is_a?(Student) ? 'Student' : 'Teacher'
      puts "#{role}: #{person.name}"
    end
  end

  def create_person_prompt
    puts 'Enter role (student/teacher):'
    role = gets.chomp.downcase
    create_person(role)
  end

  def obtain_person_data
    puts 'Enter name:'
    @name = gets.chomp

    puts 'Enter age:'
    @age = gets.chomp.to_i
  end

  def create_person(role)
    if role == 'student'
      puts 'Enter classroom:'
      classroom = gets.chomp
    end

    obtain_person_data

    if role == 'student'
      puts 'Enter parent permission (true/false):'
      parent_permission = gets.chomp.downcase == 'true'
      person = Student.new(@age, classroom, @name, parent_permission: parent_permission)
    elsif role == 'teacher'
      puts 'Enter specialization:'
      specialization = gets.chomp
      person = Teacher.new(@age, @name, specialization: specialization)
    else
      puts 'Invalid role'
      return
    end

    @people << person
    puts "#{role.capitalize} '#{name}' created."
  end

  def create_book_prompt
    puts 'Enter title:'
    title = gets.chomp

    puts 'Enter author:'
    author = gets.chomp
    book = Book.new(title, author)
    @books << book

    puts "Book '#{title}' by #{author} created."
  end

  def create_rental_prompt
    puts 'Enter person ID:'
    person_id = gets.chomp.to_i
    person = @people.find { |p| p.id == person_id }

    if person.nil?
      puts 'Person not found.'
      return
    end

    puts 'Enter book ID:'
    book_id = gets.chomp.to_i
    book = @books.find { |b| b.id == book_id }

    return unless book.nil?

    puts 'Book not found.'
    nil
  end

  def list_rentals_for_person_prompt
    puts 'Enter person ID:'
    person_id = gets.chomp.to_i
    list_rentals_for_person(person_id)
  end

  def list_rentals_for_person(person_id)
    person = @people.find { |p| p.id == person_id }
    if person.nil?
      puts 'Person not found.'
      return
    end

    # Logic to list rentals for the specified person
    person.rentals.each do |rental|
      book = @books.find { |b| b.id == rental.book_id }
      puts "Book: #{book.title}, Date: #{rental.date}"
    end
  end
end
