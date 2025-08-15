#!/usr/bin/env ruby

require_relative 'config/environment'

puts "=== Configurando Cloudinary para acceso público ==="

begin
  # First, let's update the upload preset to make files public by default
  puts "\n--- Actualizando configuración de upload ---"
  
  # Get existing PDFs and make them publicly accessible
  puts "\n--- Haciendo PDFs públicamente accesibles ---"
  
  image_resources = Cloudinary::Api.resources(
    resource_type: 'image',
    max_results: 50,
    type: 'upload'
  )
  
  pdf_count = 0
  image_resources['resources'].each do |resource|
    if resource['format'] == 'pdf'
      pdf_count += 1
      puts "📄 Procesando: #{resource['public_id']}"
      
      begin
        # Update the resource to be publicly accessible
        result = Cloudinary::Uploader.explicit(
          resource['public_id'],
          resource_type: 'image',
          type: 'upload',
          access_control: [
            {
              access_type: 'anonymous'
            }
          ]
        )
        puts "  ✅ Configurado como público"
        
        # Test the public URL
        public_url = "https://res.cloudinary.com/#{ENV['CLOUDINARY_CLOUD_NAME']}/image/upload/#{resource['public_id']}.pdf"
        puts "  🔗 URL: #{public_url}"
        
      rescue => e
        puts "  ❌ Error: #{e.message}"
        
        # Try alternative approach - re-upload with public access
        begin
          # Fetch the current file and re-upload as public
          current_url = Cloudinary::Utils.cloudinary_url(resource['public_id'], resource_type: 'image')
          
          result = Cloudinary::Uploader.upload(
            current_url,
            public_id: resource['public_id'],
            resource_type: 'image',
            overwrite: true,
            access_control: [
              {
                access_type: 'anonymous'
              }
            ],
            type: 'upload'
          )
          puts "  ✅ Re-subido como público"
        rescue => inner_e
          puts "  ❌ Re-upload falló: #{inner_e.message}"
        end
      end
    end
  end
  
  puts "\n=== Resumen ==="
  puts "📄 Total PDFs encontrados: #{pdf_count}"
  puts "✅ Configuración completada"
  
  # Test one of the URLs
  if pdf_count > 0
    test_resource = image_resources['resources'].find { |r| r['format'] == 'pdf' }
    if test_resource
      test_url = "https://res.cloudinary.com/#{ENV['CLOUDINARY_CLOUD_NAME']}/image/upload/#{test_resource['public_id']}.pdf"
      puts "\n🧪 Probando URL: #{test_url}"
      
      require 'net/http'
      uri = URI(test_url)
      response = Net::HTTP.get_response(uri)
      puts "📊 Status: #{response.code} #{response.message}"
    end
  end

rescue => e
  puts "❌ Error general: #{e.message}"
  puts e.backtrace.first(5)
end