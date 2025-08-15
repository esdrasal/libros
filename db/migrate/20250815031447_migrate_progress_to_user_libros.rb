class MigrateProgressToUserLibros < ActiveRecord::Migration[8.0]
  def up
    # Los libros con user_id = 0 son de la librería, no crear user_libros para ellos
    # Solo procesar libros con user_id válido (que existe en la tabla users)
    execute <<-SQL
      INSERT INTO user_libros (user_id, libro_id, estado, pagina_actual, created_at, updated_at)
      SELECT 
        libros.user_id,
        libros.id as libro_id,
        libros.estado,
        GREATEST(libros.pagina_actual, 1) as pagina_actual,
        NOW(),
        NOW()
      FROM libros 
      INNER JOIN users ON libros.user_id = users.id
      WHERE NOT EXISTS (
        SELECT 1 
        FROM user_libros 
        WHERE user_libros.libro_id = libros.id 
        AND user_libros.user_id = libros.user_id
      )
    SQL
  end

  def down
    # En caso de rollback, restaurar el progreso a la tabla libros
    execute <<-SQL
      UPDATE libros 
      SET 
        estado = user_libros.estado,
        pagina_actual = user_libros.pagina_actual
      FROM user_libros 
      WHERE libros.id = user_libros.libro_id 
      AND libros.user_id = user_libros.user_id
    SQL
    
    # Eliminar los user_libros creados para libros propios
    execute <<-SQL
      DELETE FROM user_libros 
      WHERE (user_id, libro_id) IN (
        SELECT user_id, id 
        FROM libros 
        WHERE user_id IS NOT NULL
      )
    SQL
  end
end
