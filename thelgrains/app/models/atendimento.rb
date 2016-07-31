# == Schema Information
#
# Table name: atendimentos
#
#  id         :integer          not null, primary key
#  servico_id :integer          not null
#  user_id    :integer          not null
#  cliente_id :integer
#  gasto_add  :decimal(, )      default(0.0)
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

##
# Model para tabela _atendimentos_
class Atendimento < ActiveRecord::Base
  belongs_to :servico, inverse_of: :atendimentos
  belongs_to :user, inverse_of: :atendimentos
  belongs_to :cliente, inverse_of: :atendimentos

  has_many :ajudantes, inverse_of: :atendimento
  has_one :entrada, inverse_of: :atendimento

  validates_numericality_of :gasto_add, allow_nil: true

  validate :ids_existence

  scope :between, ->(start_time, end_time) {
    where(created_at: start_time..end_time)
  }

  ##
  # Definição da máquina de estados.
  state_machine initial: :aberto do
    event :fechar do
      transition :aberto => :nao_pago
    end

    event :receber do
      transition :nao_pago => :pago
    end
  end

  ##
  # Procede com o fluxo de pagamento do atendimento.
  def receber_pagamento(tipo_pagamento)
    contabilizar
    key = Entrada.tipos_de_pagamento.key(tipo_pagamento)
    p key
    @entrada.update_columns(tipo_pagamento: tipo_pagamento)
  end

  ##
  # Cria e retorna a +Entrada+ criada com o atendimento.
  def contabilizar
    @entrada = Entrada.create atendimento: self, valor: valor_a_pagar
    self.receber
  end

  ##
  # Retorna o valor a pagar do cliente.
  def valor_a_pagar
    servico.valor + gasto_add
  end

  ##
  # Retorna o valor computado ao funcionário sobre o atendimento.
  def valor_funcionario_liq
    return false unless tipo_pagamento
    entrada.valor - valor_ajudantes
  end

  ##
  # Retorna o valor computado aos ajudantes do atendimento.
  def valor_ajudantes
    valor_ajudante * Ajudante.where(atendimento: self.atendimento).count
  end

  ##
  # Retorn o valor computado a um ajudante no Atendimento.
  def valor_ajudante
    Rails.configuration.taxa_principal * servico.valor_taxado / 100
  end

  ##
  # Cria ajudantes para o Atendimento +self+.
  # +users+ users a serem adicionados como ajudantes.
  def create_ajudantes(users)
    Ajudante.create_ajudantes_by_atendimento(self, users)
  end

  private

  def ids_existence
    errors.add(:user_id, "is invalid") unless User.exists?(self.user_id)
    errors.add(:servico_id, "is invalid") unless Servico.exists?(self.servico_id)
    errors.add(:cliente_id, "is invalid") unless Cliente.exists?(self.cliente_id)
  end
end
