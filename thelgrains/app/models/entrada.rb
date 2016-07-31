# == Schema Information
#
# Table name: entradas
#
#  id             :integer          not null, primary key
#  atendimento_id :integer
#  descricao      :text
#  tipo_pagamento :string
#  valor          :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

##
# Model para tabela _entradas_.
# Utilizada para contabilidade, juntamente com o model +Saida+.
class Entrada < ActiveRecord::Base

  def self.tipos_de_pagamento
    { dinheiro: 1, credito: 2, debito: 3 }.freeze
  end

  scope :between, ->(start_time, end_time) {
    where(created_at: start_time..end_time)
  }

  belongs_to :atendimento

  after_save :verify_valor, unless: -> { self.valor }

  ##
  # Retorna as despesas relacionadas ao atendimento se houver relação.
  # Se não, retorna 0.
  def despesa
    return 0.0 unless atendimento
    atendimento.servico.valor_taxado
  end

  private

  def verify_valor
    v = self.valor
    v ||= atendimento.servico.valor if atendimento
    self.update_column :valor, v
  end
end
