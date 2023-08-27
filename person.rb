class Person
    attr_reader :id, :name, :age

    def initialize(id, name = 'unknown', age, parent_permission= true)
        @id = id;
        @name= name
        @age = age
        @parent_permission = parent_permission
    end
    
    def name(new_name)
        @name = new_name
    end

    def age(new_age)
        @age = new_age
    end

    def can_use_services?
        of_age || parent_permission
    end

    private

    def of_age?
        @age>= 18
    end
end