class LibrosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_libro, only: [ :show, :leer, :guardar_pagina, :agregar_nota ]

  def index
    # Ahora todos los libros del usuario están en user_libros
    @user_libros = current_user.user_libros.includes(:libro)
  end

  def new
    @libro = Libro.new
  end

  def create
    @libro = Libro.new(libro_params.merge(user_id: 0)) # Libros de librería
    if @libro.save
      # Crear automáticamente user_libro para el usuario actual
      current_user.user_libros.create!(libro: @libro)
      redirect_to root_path, notice: "Libro agregado correctamente."
    else
      render :new
    end
  end

  def show
    # @libro ya está definido por set_libro
  end

  def leer
    # @libro ya está definido por set_libro
    # Ahora siempre usamos user_libro
    @user_libro = current_user.user_libros.find_by!(libro: @libro)

    if @user_libro.en_espera?
      @user_libro.update(estado: :leyendo)
    end

    @notas = @libro.nota.where(user: current_user)
  end

  def guardar_pagina
    # @libro ya está definido por set_libro
    # Ahora siempre usamos user_libro
    user_libro = current_user.user_libros.find_by!(libro: @libro)

    if user_libro.update(pagina_actual: params[:pagina_actual])
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def agregar_nota
    # @libro ya está definido por set_libro
    @nota = @libro.nota.new(contenido: params[:contenido], pagina: params[:pagina], user: current_user)
    if @nota.save
      render json: { success: true, nota: @nota }
    else
      render json: { success: false, errors: @nota.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def libreria
    @libros = Libro.all
    @libros_en_mi_lista = current_user.libros_en_lista.pluck(:id)
  end

  def agregar_a_lista
    @libro = Libro.find(params[:id])

    if current_user.libros_en_lista.include?(@libro)
      render json: { success: false, message: "El libro ya está en tu lista" }
    else
      current_user.user_libros.create(libro: @libro)
      render json: { success: true, message: "Libro agregado a tu lista" }
    end
  end

  def notas
    @libros_con_notas = Libro
      .joins(:nota)
      .where(nota: { user_id: current_user.id })
      .distinct
      .includes(:nota)
  end

  private

  def set_libro
    # Ahora siempre buscamos a través de user_libros
    user_libro = current_user.user_libros.find_by!(libro_id: params[:id])
    @libro = user_libro.libro
  end

  def libro_params
    params.require(:libro).permit(:titulo, :autor, :ubicacion, :pagina_actual, :pdf)
  end
end
