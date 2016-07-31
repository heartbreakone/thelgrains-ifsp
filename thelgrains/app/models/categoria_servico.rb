# == Schema Information
#
# Table name: categoria_servicos
#
#  id         :integer          not null, primary key
#  nome       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

##
# Model para tabela categoria_servicos
class CategoriaServico < ActiveRecord::Base
  has_many :servicos, inverse_of: :categoria_servico
  validates_presence_of :nome
  accepts_nested_attributes_for :servicos
end
