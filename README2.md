## Console Lab

For this exercise, you will be practicing your Rails console skills. Write out the console commands you would use to execute these queries

### To Start

1. Fork and clone the readme or create your own readme where you will place your answers
2. Create a new rails application (don't forget to `cd` into the directory)√
3. Add `pry-rails` to your `Gemfile` and run `bundle install` √
4. Make sure you have created your database √
1. Generate a model called Student, that has a first_name, last_name and age √
2. Don't forget to run your migrations √

### Tasks to create

1. Using the new/save syntax, create a student with a first and last name and an age
`student = Student.new(first_name: 'Kate', last_name: 'Stearns', age:30).save`

2. Save the student to the database √
3. Using the find/set/save syntax update the student's first name to Myles
`student.first_name = 'Myles'`
4. Delete the student (where first_name is Myles)
`student = Student.find(1)
student.destroy`

5. In your model, validate that every Student's last name is unique
6. In your model, validate that every Student has a first and last name that is longer than 4 characters
7. Validate that every first and last name cannot be empty
`class Student < ActiveRecord::Base
  validates_uniqueness_of :last_name
  validates :first_name, length: {minimum: 4}, presence: true
  validates :last_name, length: {minimum: 4}, presence: true

end
`

8. Create a migration that adds a column with a type of string called favorite_color to the students table (don't forget to run `rake db:migrate` after and for this question write the command in terminal to generate this migration)
`rails generate migration AddFavoriteColorToStudents`
`def change
    add_column :students, :favorite_color, :string
  end`

8. Using the create syntax create a student named John Doe who is 23 years old and has a favorite_color of purple
`student = Student.new(first_name: 'John', last_name: 'Doe', age: 23, favorite_color: 'purple')`

9. Show if this new student entry is valid
10. Show the number of errors for this student instance
`   (0.2ms)  BEGIN
  Student Exists (1.1ms)  SELECT  1 AS one FROM "students" WHERE "students"."last_name" = 'Doe' LIMIT 1
   (0.3ms)  ROLLBACK
=> false
irb(main):003:0> Student.all
  Student Load (0.8ms)  SELECT "students".* FROM "students"
=> #<ActiveRecord::Relation []>
irb(main):004:0> student = Student.new(first_name: 'John', last_name: 'Snow', age:23, favorite_color: 'black').save
   (0.2ms)  BEGIN
  Student Exists (0.5ms)  SELECT  1 AS one FROM "students" WHERE "students"."last_name" = 'Snow' LIMIT 1
  SQL (0.7ms)  INSERT INTO "students" ("first_name", "last_name", "age", "favorite_color", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["first_name", "John"], ["last_name", "Snow"], ["age", 23], ["favorite_color", "black"], ["created_at", "2015-10-05 22:03:17.039426"], ["updated_at", "2015-10-05 22:03:17.039426"]]
   (9.0ms)  COMMIT
=> true`

11. Using update, Change John Doe's name to Martin Fowler
13. Save Martin Fowler
`irb(main):007:0> student = Student.find(2)
  Student Load (0.8ms)  SELECT  "students".* FROM "students" WHERE "students"."id" = $1 LIMIT 1  [["id", 2]]
=> #<Student id: 2, first_name: "John", last_name: "Snow", age: 23, created_at: "2015-10-05 22:03:17", updated_at: "2015-10-05 22:03:17", favorite_color: "black">
irb(main):008:0> student.first_name = 'Martin'
=> "Martin"
irb(main):009:0> student.last_name = 'Fowler'
=> "Fowler"
irb(main):010:0> student.save
   (0.2ms)  BEGIN
  Student Exists (0.9ms)  SELECT  1 AS one FROM "students" WHERE ("students"."last_name" = 'Fowler' AND "students"."id" != 2) LIMIT 1
  SQL (0.4ms)  UPDATE "students" SET "first_name" = $1, "last_name" = $2, "updated_at" = $3 WHERE "students"."id" = $4  [["first_name", "Martin"], ["last_name", "Fowler"], ["updated_at", "2015-10-05 22:05:31.856697"], ["id", 2]]
   (1.9ms)  COMMIT
=> true`

15. Find all of the Students
`Student.all`

16. Find the student with an ID of 128 and if it does not exist, make sure it returns nil and not an error
`Student.find_by_id(128)`

17. Find the first student in the table
`Student.first`

18. Find the last student in the table
`Student.last`

19. Find the student with the last name of Fowler
`Student.where(last_name:'Fowler')`

20. Find all of students who have the first name of Martin and a favorite color of red
`Student.where(first_name:'Martin', favorite_color:'Red')`

21. Find all of the students and limit the search to 5 students, starting with the 2nd student and finally, order the students in alphabetical order
`Student.offset(2).order(last_name: :asc)`

20. Delete Martin Fowler (but first look up who he is!)
`student = Student.where(first_name: 'Martin').first
student.destroy`

21. Delete all of the students
`Student.destroy_all`

### Bonus
1. Use the validates_format_of and regex to only validate names that consist of letters (no numbers or symbols) and start with a capital letter
`validates_format_of :first_name, :last_name, :with => /\A[a-z]+\z/`

2. Write a custom validation to ensure that no one named Elie Schoppik, Colt Steele or Tim Garcia is included in the students table.
`def cannot_be_a_teacher
    if first_name == 'Elie' && last_name == 'Schoppik'
      errors.add(:last_name, "Teachers can't register as students.")
    elsif first_name =='Colt' && last_name == 'Steele'
      errors.add(:last_name, "Teachers can't register as students.")
    elsif first_name =='Time' && last_name == 'Garcia'
      errors.add(:last_name, "Teachers can't register as students.")
    else
      puts 'You pass'
    end
  end`
