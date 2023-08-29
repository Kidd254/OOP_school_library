class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author, rentals: [])
    @title = title
    @author = author
    @rentals = rentals
  end

  def add_rental(rental)
    @rentals << rental
  end

  def number_of_rentals
    @rentals.length
  end
end
