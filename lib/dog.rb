class Dog 

	attr_accessor :id, :name, :breed
	

	def initialize(id: nil, name:, breed:)
		@id = id
		@name = name
		@breed = breed
	end


	def save
	    sql = <<-SQL
	      INSERT INTO dogs (name, breed) 
	      VALUES (?, ?)
	    SQL

	    DB[:conn].execute(sql, self.name, self.breed)
	    self
  	end


	def self.create_table
	    sql = <<-SQL
	    CREATE TABLE dogs (
	    id INTEGER PRIMARY KEY,
	    name TEXT,
	    breed TEXT
    	)
    	SQL
    	DB[:conn].execute(sql)
	end


	def self.drop_table
	    sql = "DROP TABLE IF EXISTS dogs"
	    DB[:conn].execute(sql)
 	end

 	def self.create(dog_hash)
    dog = Dog.new(dog_hash)
    dog.save
    dog
 	end

 	def self.find_by_id(dog_id)
	   sql = <<-SQL
	      SELECT *
	      FROM dogs
	      WHERE id = ?
	      LIMIT 1
	    SQL
	 	
	   dog 	= DB[:conn].execute(sql, dog_id)[0]
	  	
	  	Dog.new(id: dog[0],name: dog[1],breed: dog[2])
 	end

 	def self.find_or_create_by(dog_info)
 		sql = "SELECT * FROM dogs WHERE name = ?"
	    result = DB[:conn].execute(sql, name)[0]

 	end


	

end