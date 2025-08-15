#!/usr/bin/env ruby

require_relative 'config/environment'

# Test simple upload to Cloudinary as raw
puts "=== Test de upload directo a Cloudinary ==="

begin
  # Create a simple test PDF content
  test_content = StringIO.new("%PDF-1.4\n1 0 obj\n<< /Type /Catalog /Pages 2 0 R >>\nendobj\n")
  
  # Upload directly to Cloudinary as raw
  result = Cloudinary::Uploader.upload(
    test_content,
    resource_type: "raw",
    public_id: "test_pdf_#{Time.now.to_i}",
    format: "pdf"
  )
  
  puts "✅ Upload exitoso:"
  puts "  Public ID: #{result['public_id']}"
  puts "  URL: #{result['secure_url']}"
  puts "  Resource type: #{result['resource_type']}"
  
  # Test URL accessibility
  require 'net/http'
  uri = URI(result['secure_url'])
  response = Net::HTTP.get_response(uri)
  puts "  Status al acceder: #{response.code} #{response.message}"
  
  # Clean up - delete test file
  Cloudinary::Uploader.destroy(result['public_id'], resource_type: "raw")
  puts "✅ Test file eliminado"
  
rescue => e
  puts "❌ Error: #{e.message}"
  puts e.backtrace.first(5) if e.backtrace
end