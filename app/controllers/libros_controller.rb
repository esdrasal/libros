class LibrosController < ApplicationController
  def index
    @libros = Libro.all
  end

  def new
    @libro = Libro.new
  end

  def create
     @libro = Libro.new(libro_params)
    if @libro.save
      redirect_to root_path, notice: "Libro agregado correctamente."
    else
      render :new
    end
  end

  def show
    @libro = Libro.find(params[:id])
  end

  def leer
    @libro = Libro.find(params[:id])
    
    # Cambiar estado a "leyendo" si está en "en_espera"
    if @libro.en_espera?
      @libro.update(estado: :leyendo)
    end
  end

  def guardar_pagina
    @libro = Libro.find(params[:id])
    if @libro.update(pagina_actual: params[:pagina_actual])
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def agregar_nota
    @libro = Libro.find(params[:id])
    @nota = @libro.nota.new(contenido: params[:contenido], pagina: params[:pagina])
    if @nota.save
      render json: { success: true, nota: @nota }
    else
      render json: { success: false, errors: @nota.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def libro_params
    params.require(:libro).permit(:titulo, :autor, :paginas, :ubicacion, :estado, :pagina_actual, :pdf)
  end
end
