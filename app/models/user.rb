class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :libros, dependent: :destroy
  has_many :user_libros, dependent: :destroy
  has_many :libros_en_lista, through: :user_libros, source: :libro
  has_many :nota, class_name: "Notum", dependent: :destroy
end
