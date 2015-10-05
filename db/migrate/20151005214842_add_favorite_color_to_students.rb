class AddFavoriteColorToStudents < ActiveRecord::Migration
  def change
    add_column :students, :favorite_color, :string
  end
end
