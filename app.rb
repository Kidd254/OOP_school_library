require 'json'
require 'date'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'associations/book'
require_relative 'user_interaction'
require_relative 'associations/rental'
require_relative 'storagebooks'
require_relative 'storagepeople'
require_relative 'storagerentals'

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

    name = user_int.obtain_person_name

    age = user_int.obtain_person_age

    if role == 'student'
      classroom = user_int.classroom_value
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

  def list_rentals
    @rental.each do |rt|
      puts "date: #{rt.date}, title: #{rt.book.title}, person: #{rt.person.name}"
    end
  end

  def save_data
    databook = Storagebooks.new
    databook.save_books(@books)

    datapeople = Storagepeople.new
    datapeople.save_people(@people)

    datarentals = Storagerentals.new
    datarentals.save_rentals(@rental)
  end

  def load_data
    databook = Storagebooks.new
    @books = databook.load_books

    datapeople = Storagepeople.new
    @people = datapeople.load_people

    datarentals = Storagerentals.new
    @rental = datarentals.load_rentals
  end
end
