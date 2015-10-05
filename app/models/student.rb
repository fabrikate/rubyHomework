class Student < ActiveRecord::Base
  validates_uniqueness_of :last_name
  validates :first_name, length: {minimum: 4}, presence: true
  validates :last_name, length: {minimum: 4}, presence: true
  validates_format_of :first_name, :last_name, :with => /\A[a-z]+\z/

  def cannot_be_a_teacher
    if first_name == 'Elie' && last_name == 'Schoppik'
      errors.add(:last_name, "Teachers can't register as students.")
    elsif first_name =='Colt' && last_name == 'Steele'
      errors.add(:last_name, "Teachers can't register as students.")
    elsif first_name =='Tim' && last_name == 'Garcia'
      errors.add(:last_name, "Teachers can't register as students.")
    else
      puts 'You pass'
    end
  end
end
