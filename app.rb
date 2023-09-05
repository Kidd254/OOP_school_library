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

  def create_person(role)
    if role == 'student'
      puts 'Enter classroom:'
      classroom = gets.chomp
    end

    name, age = obtain_person_data

    if role == 'student'
      puts 'Enter parent permission (true/false):'
      parent_permission = gets.chomp.downcase == 'true'
      person = Student.new(age, classroom, name, parent_permission: parent_permission)
    elsif role == 'teacher'
      puts 'Enter specialization:'
      specialization = gets.chomp
      person = Teacher.new(age, name, specialization: specialization)
    else
      puts 'Invalid role'
      return
    end

    @people << person
    puts "#{role.capitalize} '#{name}' created."
  end

  def obtain_person_data
    puts 'Enter name:'
    name = gets.chomp

    puts 'Enter age:'
    age = gets.chomp.to_i

    [name, age]
  end

  def create_book_prompt
    title = enter_book_title
    author = enter_book_author

    book = Book.new(title, author)
    @books << book

    puts "Book '#{title}' by #{author} created."
  end

  def enter_book_title
    puts 'Enter title:'
    gets.chomp
  end

  def enter_book_author
    puts 'Enter author:'
    gets.chomp
  end

  def create_rental_prompt
    person_id = enter_person_id
    book_id = enter_book_id

    create_rental(person_id, book_id)
  end

  def enter_person_id
    puts 'Enter person ID:'
    gets.chomp.to_i
  end

  def enter_book_id
    puts 'Enter book ID:'
    gets.chomp.to_i
  end

  def create_rental(person_id, book_id)
    person = @people.find { |p| p.id == person_id }

    if person.nil?
      puts 'Person not found.'
      return
    end

    book = @books.find { |b| b.id == book_id }

    if book.nil?
      puts 'Book not found.'
      return
    end

    rental = Rental.new(person.id, book.id, Date.today)
    @rental << rental

    puts "Rental created for '#{person.name}' and '#{book.title}' on #{Date.today}."
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

    person.rentals.each do |rental|
      book = @books.find { |b| b.id == rental.book_id }
      puts "Book: #{book.title}, Date: #{rental.date}"
    end
  end
end
