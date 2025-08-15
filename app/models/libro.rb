class Libro < ApplicationRecord
  has_one_attached :pdf
  has_many :nota, class_name: 'Notum', dependent: :destroy
  enum :estado, { en_espera: 0, leyendo: 1, leido: 2 }

  validates :titulo, :autor, :paginas, presence: true
  validate :pdf_attached
  validate :pdf_content_type

  def progreso
    return 0 if pagina_actual.nil? || paginas.zero?
    ((pagina_actual.to_f / paginas) * 100).round
  end

  def pdf_url_for_viewer
    return nil unless pdf.attached?
    
    # Use Rails.application.routes.url_helpers for local storage
    Rails.application.routes.url_helpers.rails_blob_url(pdf, host: "localhost:3000")
  end

  private

  def pdf_attached
    errors.add(:pdf, 'debe estar adjunto') unless pdf.attached?
  end

  def pdf_content_type
    if pdf.attached? && !pdf.content_type.in?(['application/pdf'])
      errors.add(:pdf, 'debe ser un archivo PDF')
    end
  end
end
