class Notum < ApplicationRecord
  belongs_to :libro
  validates :contenido, presence: true
  validates :pagina, presence: true
end
