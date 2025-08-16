class AddPdfUrlToLibros < ActiveRecord::Migration[8.0]
  def change
    add_column :libros, :pdf_url, :string, null: true, comment: "URL del PDF del libro almacenado en Cloudinary"

  end
end
