require_relative 'app'

class Storagebooks
  def load_books
    return [] unless File.exist?('books.json')

    book_data = JSON.parse(File.read('books.json'))
    book_data.map { |data| Book.from_hash(data) }
  end

  def save_books(data)
    book_data = data.map(&:to_hash)
    File.write('books.json', JSON.generate(book_data))
  end
end
