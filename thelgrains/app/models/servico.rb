# == Schema Information
#
# Table name: servicos
#
#  id                   :integer          not null, primary key
#  categoria_servico_id :integer          not null
#  nome                 :string
#  valor                :decimal(, )
#  taxa                 :decimal(, )
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

##
# Model para tabela _servicos_
class Servico < ActiveRecord::Base
  belongs_to :categoria_servico, inverse_of: :servicos

  has_many :atendimentos

  validates_presence_of :nome, :categoria_servico, :valor, :taxa
  validates :valor, :taxa, numericality: true

  ##
  # Retorna o valor do serviço segundo a taxa ao funcionário.
  def valor_taxado
    valor * taxa / 100
  end

end
