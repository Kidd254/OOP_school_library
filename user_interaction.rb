class Userinteraction
  def create_role
    puts 'Enter role (student/teacher):'
    gets.chomp.downcase
  end

  def classroom_value
    puts 'Enter classroom:'
    gets.chomp
  end

  def obtain_person_name
    puts 'Enter name:'
    gets.chomp
  end

  def obtain_person_age
    puts 'Enter age:'
    gets.chomp.to_i
  end

  def parent_permission_value
    puts 'Enter parent permission (y)es or (n)o'
    parent_permission = gets.chomp
    parent_permission == 'y'
  end

  def specialization_value
    puts 'Enter specialization:'
    gets.chomp
  end

  def enter_book_title
    puts 'Enter title:'
    gets.chomp
  end

  def enter_book_author
    puts 'Enter author:'
    gets.chomp
  end

  def enter_person_id
    puts 'Enter person ID:'
    gets.chomp.to_i
  end

  def enter_book_id
    puts 'Enter book index:'
    gets.chomp.to_i
  end
end
