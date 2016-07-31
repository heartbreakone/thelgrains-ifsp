module Web

  ##
  # Controlador da página atendimentos da interface web.
  class AtendimentosController < ApplicationController
    include Webable

    # GET em /atendimentos
    def index
      rel = Atendimento.where(state: 'aberto').order(updated_at: :asc)
      @q = rel.ransack params[:q]
      @atendimentos = @q.result.page params[:page]
    end

    def show
    end

    def create
      @at = Atendimento.new(atendimento_params)
      if @at.save
        users = User.where(id: ajudantes_params[:ajudante_ids])
        @at.ajudantes.create(users.map { |u| { user_id: u.id } })
      else
      end
    end

    def update
      at = Atendimento.find(params[:id]) || Atendimento.new
      if params[:fechar]
        if at.fechar
          head status: 202
        else
          head status: 400
        end
      else
        head status: 400
      end
    end

    private

    def atendimento_params
      params.require(:atendimento).permit(:user_id, :servico_id, :cliente_id, :gasto_add, :data)
    end

    def ajudantes_params
      params.require(:atendimento).permit(ajudante_ids: [])
    end

  end
end
