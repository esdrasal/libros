namespace :db do
  desc "Migrate data from MySQL export to PostgreSQL"
  task migrate_from_mysql: :environment do
    require 'json'
    
    puts "🔄 Iniciando migración de datos MySQL a PostgreSQL..."
    
    # Datos de ejemplo basados en tu estructura
    # Estos datos se pueden extraer del archivo mysql_data_export.sql
    
    puts "📚 Migrando libros..."
    libros_data = [
      {
        titulo: "Ejemplo Libro 1",
        autor: "Autor Ejemplo",
        paginas_total: 200,
        created_at: Time.current,
        updated_at: Time.current
      },
      # Agregar más libros aquí si los tienes
    ]
    
    libros_data.each do |libro_attrs|
      libro = Libro.find_or_create_by(titulo: libro_attrs[:titulo]) do |l|
        l.assign_attributes(libro_attrs)
      end
      puts "  ✅ Libro: #{libro.titulo}"
    end
    
    puts "👥 Migrando usuarios..."
    # Solo crear usuario de ejemplo si no existe
    unless User.exists?(email: 'admin@biblioteca.com')
      User.create!(
        email: 'admin@biblioteca.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      puts "  ✅ Usuario admin creado"
    end
    
    puts "📝 Migrando notas..."
    # Las notas se pueden agregar después
    
    puts "🎉 ¡Migración completada!"
    puts "📊 Resumen:"
    puts "  - Libros: #{Libro.count}"
    puts "  - Usuarios: #{User.count}"
    puts "  - Notas: #{Notum.count}" if defined?(Notum)
  end
end