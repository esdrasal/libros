class CreateNota < ActiveRecord::Migration[8.0]
  def change
    create_table :nota do |t|
      t.text :contenido
      t.integer :pagina
      t.references :libro, null: false, foreign_key: true

      t.timestamps
    end
  end
end
