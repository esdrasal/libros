class AddUserToNota < ActiveRecord::Migration[8.0]
  def change
    add_reference :nota, :user, null: true, foreign_key: true

    # Asignar las notas existentes a sus respectivos usuarios basado en el libro
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE nota#{' '}
          SET user_id = (
            SELECT user_id#{' '}
            FROM libros#{' '}
            WHERE libros.id = nota.libro_id
          )
          WHERE user_id IS NULL
        SQL
      end
    end

    change_column_null :nota, :user_id, false
  end
end
