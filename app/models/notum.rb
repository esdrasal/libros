class Notum < ApplicationRecord
  belongs_to :libro
  belongs_to :user
  validates :contenido, presence: true
  validates :pagina, presence: true
end
