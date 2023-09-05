require_relative 'book'
require_relative '../person'

class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person

    book.add_rental(self)
    person.add_rental(self)
  end

  def to_hash
    {
      date: @date.to_s,
      book: @book.to_hash,
      person: @person.to_hash
    }
  end

  # Create a Rental object from a hash
  def self.from_hash(data)
    date = Date.parse(data['date'])
    book = Book.from_hash(data['book'])
    person = Person.from_hash(data['person'])
    Rental.new(date, book, person)
  end
end
