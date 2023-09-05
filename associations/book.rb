require_relative 'rental'

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  def number_of_rentals
    @rentals.length
  end

  def to_hash
    {
      title: @title,
      author: @author
    }
  end

  # Create a Book object from a hash
  def self.from_hash(data)
    title = data['title']
    author = data['author']
    Book.new(title, author)
  end
end

