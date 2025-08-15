class NotumController < ApplicationController
  def destroy
    @notum = Notum.find(params[:id])
    @notum.destroy
    redirect_to notas_libros_path, notice: "Nota eliminada correctamente."
  end

  def update
    @notum = Notum.find(params[:id])
    if @notum.update(nota_params)
      redirect_to notas_libros_path, notice: "Nota actualizada correctamente."
    else
      render :edit
    end
  end


  private

  def nota_params
    params.require(:notum).permit(:contenido, :pagina).merge(user: current_user)
  end
end
