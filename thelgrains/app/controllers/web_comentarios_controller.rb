##
# Controlador para o formulário de comentarios no index.
class WebComentariosController < ApplicationController
  include XhrRequestable

  def create
    @web_comentario = WebComentario.new(web_comentario_params)

    respond_to do |format|
      if @web_comentario.save
        format.json { render nothing: true, status: :created }
      else
        format.json { render json: @web_comentario.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def web_comentario_params
    params.require(:web_comentario).permit(:nome, :email, :comentario)
  end
end
