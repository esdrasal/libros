class AddProgressToUserLibros < ActiveRecord::Migration[8.0]
  def change
    add_column :user_libros, :estado, :integer, default: 0
    add_column :user_libros, :pagina_actual, :integer, default: 0
  end
end
