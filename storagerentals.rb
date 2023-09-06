require_relative 'app'
require_relative 'person'

class Storagerentals
  def load_rentals
    return [] unless File.exist?('rentals.json')

    rentals_data = JSON.parse(File.read('rentals.json'))

    rentals_data.map do |item|
      book = Book.from_hash(item['book'])
      person = Person.from_hash(item['person'])
      Rental.new(Date.parse(item['date']), book, person)
    end
  end

  def save_rentals(data)
    rental_data = data.map(&:to_hash)
    File.write('rentals.json', JSON.generate(rental_data))
  end
end
