module Api
  class AtendimentosController < ApplicationController
  include Apiable

    def index
      @atendimentos = Atendimento.where(user_id: params[:user_id])
    end

    def create
      @atendimento = Atendimento.new(atendimento_params)
      if @atendimento.save
        users = User.where(id: ajudantes_params[:users_id])
        @atendimento.ajudantes.create(users.map { |u| { user_id: u.id } })
        render json: { success: true, id: @atendimento.id }
      else
        render json: { success: false, errors: @atendimento.errors.messages }
      end
    end

    private

    def atendimento_params
      params.require(:atendimento).permit(:user_id, :cliente_id, :servico_id, :gasto_add)
    end

    def ajudantes_params
      params.require(:atendimento).permit(users_id: [])
    end
  end
end
