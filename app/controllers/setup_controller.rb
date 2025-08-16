class SetupController < ApplicationController
  # Temporal controller for database setup on Railway
  skip_before_action :verify_authenticity_token
  
  def migrate
    if Rails.env.production?
      begin
        # Run migrations
        ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths)
        
        render json: { 
          status: 'success', 
          message: 'Migrations completed successfully',
          tables: ActiveRecord::Base.connection.tables
        }
      rescue => e
        render json: { 
          status: 'error', 
          message: e.message 
        }
      end
    else
      render json: { status: 'error', message: 'Only available in production' }
    end
  end
  
  def migrate_data
    if Rails.env.production?
      begin
        # Create sample data (replace with your actual data)
        unless User.exists?(email: 'admin@biblioteca.com')
          User.create!(
            email: 'admin@biblioteca.com',
            password: 'password123',
            password_confirmation: 'password123'
          )
        end
        
        # Add your books data here
        sample_books = [
          { titulo: 'Don Quijote', autor: 'Cervantes', paginas_total: 1000 },
          { titulo: 'Cien años de soledad', autor: 'García Márquez', paginas_total: 450 }
        ]
        
        sample_books.each do |book_data|
          Libro.find_or_create_by(titulo: book_data[:titulo]) do |libro|
            libro.assign_attributes(book_data)
          end
        end
        
        render json: { 
          status: 'success', 
          message: 'Data migration completed',
          users: User.count,
          libros: Libro.count
        }
      rescue => e
        render json: { 
          status: 'error', 
          message: e.message 
        }
      end
    else
      render json: { status: 'error', message: 'Only available in production' }
    end
  end
end