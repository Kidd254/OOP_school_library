require_relative 'app'

class Storagepeople
  def load_people
    return [] unless File.exist?('people.json')

    people_data = JSON.parse(File.read('people.json'))

    people_data.map do |item|
      if item['role'] == 'student'
        Student.from_hash(item)
      else
        Teacher.from_hash(item)
      end
    end
  end

  def save_people(data)
    people_data = data.map(&:to_hash)
    File.write('people.json', JSON.generate(people_data))
  end
end
