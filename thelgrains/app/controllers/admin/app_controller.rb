module Admin

  ##
  # Controlador das páginas inicial e contabilidade
  class AppController < ApplicationController
    include Administrable

    def dashboard
    end

    def contabilidade
      @receitas = Entrada.all.page params[:receitas_page]
      @despesas = Saida.all.page params[:despesas_page]
      @total_em_caixa = @receitas.between(DateTime.now.beginning_of_day, DateTime.now.end_of_day)
      @total_em_caixa = @total_em_caixa.where(tipo_pagamento: Entrada.tipos_de_pagamento[:dinheiro]).sum(:valor)
      @sum_despesas = @despesas.sum(:valor)
      @sum_receitas = @receitas.sum(:valor)
      despesa = 0
      @receitas.each do |r| despesa += r.despesa end
      @sum_receitas_liq = @sum_receitas - despesa
    end

  end
end
