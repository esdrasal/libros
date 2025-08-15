class UserLibro < ApplicationRecord
  belongs_to :user
  belongs_to :libro
  
  enum :estado, { en_espera: 0, leyendo: 1, leido: 2 }
  
  validates :user_id, uniqueness: { scope: :libro_id }
  
  after_initialize :set_default_estado, if: :new_record?
  
  def progreso
    return 0 if pagina_actual.nil? || libro.paginas.zero?
    ((pagina_actual.to_f / libro.paginas) * 100).round(1)
  end
  
  private
  
  def set_default_estado
    self.estado ||= :en_espera
  end
end
