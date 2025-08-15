class CreateLibros < ActiveRecord::Migration[8.0]
  def change
    create_table :libros do |t|
      t.string :titulo
      t.string :autor
      t.integer :paginas
      t.string :ubicacion
      t.integer :estado
      t.integer :pagina_actual

      t.timestamps
    end
  end
end
