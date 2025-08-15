#!/usr/bin/env ruby

require_relative 'config/environment'

puts "=== Verificando archivos en Cloudinary ==="

begin
  # Check raw files
  puts "\n--- Archivos RAW ---"
  raw_resources = Cloudinary::Api.resources(resource_type: 'raw', max_results: 20)
  puts "Total: #{raw_resources['resources'].length}"
  raw_resources['resources'].each do |resource|
    puts "✓ #{resource['public_id']} (#{resource['bytes']} bytes)"
  end
  
  # Check image files (where Active Storage uploads by default)
  puts "\n--- Archivos IMAGE ---"
  image_resources = Cloudinary::Api.resources(resource_type: 'image', max_results: 20)
  puts "Total: #{image_resources['resources'].length}"
  image_resources['resources'].each do |resource|
    puts "✓ #{resource['public_id']} (#{resource['bytes']} bytes) - Format: #{resource['format']}"
  end
  
  # Check specific file
  key = 'd7gzhux1qqwt3s201jkv8mwe6uw0'
  puts "\n--- Buscando archivo específico: #{key} ---"
  
  begin
    resource_raw = Cloudinary::Api.resource(key, resource_type: 'raw')
    puts "✅ Encontrado como RAW: #{resource_raw['secure_url']}"
  rescue Cloudinary::Api::NotFound
    puts "❌ No encontrado como RAW"
  end
  
  begin
    resource_image = Cloudinary::Api.resource(key, resource_type: 'image')
    puts "✅ Encontrado como IMAGE: #{resource_image['secure_url']}"
  rescue Cloudinary::Api::NotFound
    puts "❌ No encontrado como IMAGE"
  end

rescue => e
  puts "Error: #{e.message}"
end