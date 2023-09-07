require_relative 'spec_helper'
require 'date'

RSpec.describe Rental do
  let(:book) { Book.new('El viejo y el mar', 'Ernest Hemingway') }
  let(:person) { Person.new(30) }

  describe '#initialize' do
    it 'creates a new Rental instance' do
      rental = Rental.new('2023/9/6', book, person)
      expect(rental).to be_an_instance_of(Rental)
    end

    it 'initializes the date, book, and person' do
      rental = Rental.new('2023/9/6', book, person)
      expect(rental.date).to eq('2023/9/6')
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end

    it 'adds the rental to the book and person' do
      rental = Rental.new('2023/9/6', book, person)
      expect(book.rentals).to include(rental)
      expect(person.rentals).to include(rental)
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the rental' do
      rental = Rental.new('2023/9/6', book, person)
      rental_hash = rental.to_hash
      expect(rental_hash).to be_a(Hash)
      expect(rental_hash[:date]).to eq('2023/9/6')
      expect(rental_hash[:book]).to eq(book.to_hash)
      expect(rental_hash[:person]).to eq(person.to_hash)
    end
  end

  describe '.from_hash' do
    it 'creates a Rental object from a hash' do
      rental_hash = {
        'date' => '2023/9/6',
        'book' => { 'title' => 'El viejo y el mar', 'author' => 'Ernest Hemingway' },
        'person' => { 'name' => 'Sample Person' }
      }
      rental = Rental.from_hash(rental_hash)
      expect(rental).to be_an_instance_of(Rental)
      expect(rental.date).to eq(Date.new(2023, 9, 6))
      expect(rental.book.title).to eq('El viejo y el mar')
      expect(rental.person.name).to eq('Sample Person')
    end
  end
end
