class RemoveProgressFromLibros < ActiveRecord::Migration[8.0]
  def change
    remove_column :libros, :estado, :string
    remove_column :libros, :pagina_actual, :string
  end
end
