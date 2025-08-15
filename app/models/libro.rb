class Libro < ApplicationRecord
  belongs_to :user, optional: true
  has_one_attached :pdf
  has_many :nota, class_name: "Notum", dependent: :destroy
  has_many :user_libros, dependent: :destroy
  has_many :usuarios_en_lista, through: :user_libros, source: :user
  # El estado ahora se maneja en user_libros, no en libros
  after_commit :extract_pdf_pages, on: [ :create, :update ]

  validates :titulo, :autor, presence: true
  validate :pdf_attached
  validate :pdf_content_type

  # El progreso ahora se calcula desde user_libros

  def pdf_url_for_viewer
    return nil unless pdf.attached?

    # Use Rails.application.routes.url_helpers for local storage
    Rails.application.routes.url_helpers.rails_blob_url(pdf, host: "localhost:3000")
  end

  private

  def extract_pdf_pages
    return unless pdf.attached? && paginas.nil?

    begin
      pdf.open do |file|
        reader = PDF::Reader.new(file)
        update_column(:paginas, reader.page_count)
      end
    rescue LoadError => e
      Rails.logger.error "PDF Reader gem no disponible: #{e.message}"
    rescue => e
      Rails.logger.error "Error al extraer páginas del PDF: #{e.message}"
    end
  end

  def pdf_attached
    errors.add(:pdf, "debe estar adjunto") unless pdf.attached?
  end

  def pdf_content_type
    if pdf.attached? && !pdf.content_type.in?([ "application/pdf" ])
      errors.add(:pdf, "debe ser un archivo PDF")
    end
  end
end
