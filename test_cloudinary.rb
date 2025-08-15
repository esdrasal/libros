#!/usr/bin/env ruby

# Test Cloudinary connection and existing files
require_relative 'config/environment'

puts "=== Test de Cloudinary ==="
puts "Cloud name: #{ENV['CLOUDINARY_CLOUD_NAME']}"
puts "API key: #{ENV['CLOUDINARY_API_KEY']}"
puts "API secret: #{ENV['CLOUDINARY_API_SECRET'] ? '[SET]' : '[NOT SET]'}"

begin
  # Test connection
  puts "\n=== Probando conexión ==="
  result = Cloudinary::Api.ping
  puts "✅ Conexión exitosa: #{result}"
  
  # List existing resources
  puts "\n=== Archivos existentes ==="
  resources = Cloudinary::Api.resources(resource_type: 'raw', max_results: 10)
  puts "Total de archivos raw: #{resources['resources'].length}"
  
  resources['resources'].each do |resource|
    puts "- #{resource['public_id']} (#{resource['bytes']} bytes)"
  end
  
  # Test existing PDFs from database
  puts "\n=== PDFs en la base de datos ==="
  Libro.includes(:pdf_attachment).each do |libro|
    if libro.pdf.attached?
      puts "📚 #{libro.titulo}:"
      puts "  - Key: #{libro.pdf.key}"
      puts "  - Filename: #{libro.pdf.filename}"
      puts "  - Size: #{libro.pdf.byte_size}"
      
      begin
        url = libro.pdf.url
        puts "  - URL: #{url}"
        
        # Test URL accessibility
        require 'net/http'
        uri = URI(url)
        response = Net::HTTP.get_response(uri)
        puts "  - Status: #{response.code} #{response.message}"
      rescue => e
        puts "  - Error generando URL: #{e.message}"
      end
    else
      puts "📚 #{libro.titulo}: Sin PDF adjunto"
    end
  end
  
rescue Cloudinary::Api::Error => e
  puts "❌ Error de Cloudinary: #{e.message}"
rescue => e
  puts "❌ Error general: #{e.message}"
end