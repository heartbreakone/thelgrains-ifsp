module Web

  ##
  # Controlador da página caixa da interface web.
  class CaixaController < ApplicationController
    include Webable
    include XhrRequestable

    before_action :set_atendimento, only: [:show, :update]

    # GET em /caixa
    def index
      rel = Atendimento.where(state: ['nao_pago', 'pago']).order(updated_at: :asc)
      @q = rel.ransack params[:q]
      @atendimentos = @q.result.page params[:page]
    end

    def show
    end

    def update
      if atendimento_params[:pago] == 'true'
        @atendimento.receber_pagamento(atendimento_params[:tipo_pagamento])
        flash[:notice] = 'Sucesso!'
      else
        flash[:notice] = 'Não foi possível finalizar o pagamento!'
      end
      render json: { redirect: '/caixa' }
    end

    private

    def atendimento_params
      params.require(:atendimento).permit(:id, :tipo_pagamento, :pago)
    end

    def set_atendimento
      @atendimento = Atendimento.find params[:id] || Atendimento.new
    end

  end
end
