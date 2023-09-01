require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'associations/book'
class App
  def initialize(books: [], people: [], rental: [])
    @books = books
    @people = people
    @rental = rental
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

  # rubocop:disable Metrics/MethodLength
  def create_person(role)
    classroom = nil

    if role == 'student'
      puts 'Enter classroom:'
      classroom = gets.chomp
    end
    puts 'Enter name:'
    name = gets.chomp

    puts 'Enter age:'
    age = gets.chomp.to_i

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

  # rubocop:enable Metrics/MethodLength
  def create_book
    puts 'Enter title:'
    title = gets.chomp

    puts 'Enter author:'
    author = gets.chomp
    book = Book.new(title, author)
    @books << book

    puts "Book '#{title}' by #{author} created."
  end

  def list_rentals_for_person(person_id)
    person = @people.find { |p| p.id == person_id }
    return unless person

    person.rentals.each do |rental|
      book = @books.find { |b| b.id == rental.book_id }
      puts "Book: #{book.title}, Date: #{rental.date}"
    end
  end
end
