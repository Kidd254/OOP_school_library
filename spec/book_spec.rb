require_relative '../associations/book'
require_relative '../teacher'

RSpec.describe Book do
  let(:book) { Book.new('El viejo y el mar', 'Ernest Hemingway') }
  let(:teacher) { Teacher.new(60) }

  describe '#initialize' do
    it 'creates a new Book instance' do
      expect(book).to be_an_instance_of(Book)
    end
    it 'initializes the title and author' do
      expect(book.title).to eq('El viejo y el mar')
      expect(book.author).to eq('Ernest Hemingway')
    end

    it 'initializes an empty rentals array' do
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_rental' do
    it 'adds a rental to the rentals array' do
      rental = Rental.new('23/09/23', book, teacher)
      book.add_rental(rental)
      expect(book.rentals).to include(rental)
    end
  end

  describe '#number_of_rentals' do
    it 'returns the number of rentals' do
      rental = Rental.new('23/10/23', book, teacher)
      book.add_rental(rental)
      expect(book.number_of_rentals).to eq(2)
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the book' do
      book_hash = book.to_hash
      expect(book_hash).to be_a(Hash)
      expect(book_hash[:title]).to eq('El viejo y el mar')
      expect(book_hash[:author]).to eq('Ernest Hemingway')
    end
  end

  describe '.from_hash' do
    it 'creates a Book object from a hash' do
      book_hash = { 'title' => 'El viejo y el mar', 'author' => 'Ernest Hemingway' }
      new_book = Book.from_hash(book_hash)
      expect(new_book).to be_an_instance_of(Book)
      expect(new_book.title).to eq('El viejo y el mar')
      expect(new_book.author).to eq('Ernest Hemingway')
    end
  end
end
